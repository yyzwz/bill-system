package cn.zwz.modules.social.controller;

import cn.zwz.common.annotation.SystemLog;
import cn.zwz.common.constant.CommonConstant;
import cn.zwz.common.constant.SecurityConstant;
import cn.zwz.common.enums.LogType;
import cn.zwz.common.utils.ResultUtil;
import cn.zwz.common.utils.SecurityUtil;
import cn.zwz.config.security.SecurityUserDetails;
import cn.zwz.modules.base.entity.User;
import cn.zwz.modules.social.entity.Social;
import cn.zwz.modules.social.service.SocialService;
import cn.zwz.modules.social.vo.AccessToken;
import cn.zwz.common.vo.Result;
import cn.zwz.modules.social.vo.WeiboUserInfo;
import cn.hutool.core.util.StrUtil;
import cn.hutool.http.HttpUtil;
import com.google.gson.Gson;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * http://open.weibo.com/wiki/Connect/login
 * @author 郑为中
 */
@Slf4j
@Api(description = "微博登录接口")
@RequestMapping("/xboot/social/weibo")
@Controller
public class WeiboController {

    @Value("${xboot.social.weibo.appKey}")
    private String appKey;

    @Value("${xboot.social.weibo.appSecret}")
    private String appSecret;

    @Value("${xboot.social.weibo.callbackUrl}")
    private String callbackUrl;

    @Value("${xboot.social.callbackFeUrl}")
    private String callbackFeUrl;

    @Value("${xboot.social.callbackFeRelateUrl}")
    private String callbackFeRelateUrl;

    @Autowired
    private SocialService socialService;

    @Autowired
    private SecurityUtil securityUtil;

    @Autowired
    private StringRedisTemplate redisTemplate;

    /**
     * 微博认证服务器地址
     */
    private static final String AUTHORIZE_URL = "https://api.weibo.com/oauth2/authorize";

    /**
     * 申请令牌地址
     */
    private static final String ACCESS_TOKEN_URL = "https://api.weibo.com/oauth2/access_token";

    /**
     * 获取用户uid
     */
    private static final String GET_USERINFO_URL = "https://api.weibo.com/oauth2/get_token_info";

    /**
     * 获取用户详细信息地址
     */
    private static final String GET_USERINFO_DETAIL_URL = "https://api.weibo.com/2/users/show.json";

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    @ApiOperation(value = "获取微博认证链接")
    @ResponseBody
    public Result<Object> login(){

        // 生成并保存state 忽略该参数有可能导致CSRF攻击
        String state = String.valueOf(System.currentTimeMillis());
        redisTemplate.opsForValue().set(SecurityConstant.WEIBO_STATE + state, "VALID", 3L, TimeUnit.MINUTES);

        // 传递参数response_type、client_id、state、redirect_uri
        String url = AUTHORIZE_URL + "?response_type=code&" + "client_id=" + appKey + "&state=" + state
                + "&redirect_uri=" + callbackUrl;

        return ResultUtil.data(url);
    }

    @RequestMapping(value = "/callback", method = RequestMethod.GET)
    @ApiOperation(value = "获取accessToken")
    @SystemLog(description = "微博关联登录", type = LogType.LOGIN)
    public String getAccessToken(@RequestParam(required = false) String code,
                                 @RequestParam(required = false) String state) throws UnsupportedEncodingException {

        if(StrUtil.isBlank(code)){
            return "redirect:" + callbackFeUrl + "?error=" + URLEncoder.encode("您未同意授权","utf-8");
        }
        // 验证state
        String v = redisTemplate.opsForValue().get(SecurityConstant.WEIBO_STATE + state);
        redisTemplate.delete(SecurityConstant.WEIBO_STATE + state);
        if(StrUtil.isBlank(v)) {
            return "redirect:" + callbackFeUrl + "?error=" + URLEncoder.encode("授权超时或state不正确","utf-8");
        }

        // 传递参数grant_type、code、redirect_uri、client_id
        String params = "grant_type=authorization_code&code=" + code + "&redirect_uri=" +
                callbackUrl + "&client_id=" + appKey + "&client_secret=" + appSecret;

        // 申请令牌 post请求
        String result = HttpUtil.post(ACCESS_TOKEN_URL, params);
        if(!result.contains("\"access_token\":")){
            return "redirect:" + callbackFeUrl + "?error=" + URLEncoder.encode("获取access_token失败","utf-8");
        }

        String accessToken = new Gson().fromJson(result, AccessToken.class).getAccess_token();
        // 获取用户uid post请求
        String uIdParams = "access_token=" + accessToken;
        String uIdInfo = HttpUtil.post(GET_USERINFO_URL, uIdParams);
        WeiboUserInfo wb = new Gson().fromJson(uIdInfo, WeiboUserInfo.class);
        String uid = wb.getUid();
        // 获取详细信息
        String userInfo = HttpUtil.get(GET_USERINFO_DETAIL_URL + "?access_token=" + accessToken + "&uid=" + uid);
        wb = new Gson().fromJson(userInfo, WeiboUserInfo.class);
        // 存入数据库
        Social w = socialService.findByOpenIdAndPlatform(uid, CommonConstant.SOCIAL_TYPE_WEIBO);
        if(w==null){
            Social newb = new Social().setOpenId(uid).setUsername(wb.getName()).setAvatar(wb.getProfile_image_url()).setPlatform(CommonConstant.SOCIAL_TYPE_WEIBO);
            w = socialService.save(newb);
        }

        String url = "";
        // 判断是否绑定账号
        if(StrUtil.isNotBlank(w.getRelateUsername())){
            // 已绑定 直接登录
            String JWT = securityUtil.getToken(w.getRelateUsername(), true);
            // 存入redis
            String JWTKey = UUID.randomUUID().toString().replace("-","");
            redisTemplate.opsForValue().set(JWTKey, JWT, 2L, TimeUnit.MINUTES);
            url = callbackFeUrl + "?related=1&JWTKey=" + JWTKey;
            // 记录日志使用
            UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
                    new SecurityUserDetails(new User().setUsername(w.getRelateUsername())), null, null);
            SecurityContextHolder.getContext().setAuthentication(authentication);
        }else{
            // 未绑定 Redis存入id
            String idToken = UUID.randomUUID().toString().replace("-","");
            redisTemplate.opsForValue().set(idToken, w.getId(), 5L, TimeUnit.MINUTES);
            url = callbackFeRelateUrl + "?socialType="+ CommonConstant.SOCIAL_TYPE_WEIBO +"&id=" + idToken;
        }
        return "redirect:" + url;
    }
}
