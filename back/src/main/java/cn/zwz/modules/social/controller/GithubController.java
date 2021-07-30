package cn.zwz.modules.social.controller;

import cn.zwz.common.annotation.SystemLog;
import cn.zwz.common.constant.CommonConstant;
import cn.zwz.common.constant.SecurityConstant;
import cn.zwz.common.enums.LogType;
import cn.zwz.common.utils.SecurityUtil;
import cn.zwz.config.security.SecurityUserDetails;
import cn.zwz.modules.base.entity.User;
import cn.zwz.modules.social.entity.Social;
import cn.zwz.modules.social.vo.GithubUserInfo;
import cn.zwz.common.utils.ResultUtil;
import cn.zwz.common.vo.Result;
import cn.zwz.modules.social.service.SocialService;
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
import org.springframework.web.bind.annotation.*;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/
 * @author 郑为中
 */
@Slf4j
@Api(description = "Github登录接口")
@RequestMapping("/xboot/social/github")
@Controller
public class GithubController {

    @Value("${xboot.social.github.clientId}")
    private String clientId;

    @Value("${xboot.social.github.clientSecret}")
    private String clientSecret;

    @Value("${xboot.social.github.callbackUrl}")
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
     * Github认证服务器地址
     */
    private static final String AUTHORIZE_URL = "https://github.com/login/oauth/authorize";

    /**
     * 申请令牌地址
     */
    private static final String ACCESS_TOKEN_URL = "https://github.com/login/oauth/access_token";

    /**
     * 获取用户信息地址
     */
    private static final String GET_USERINFO_URL = "https://api.github.com/user?access_token=";

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    @ApiOperation(value = "获取github认证链接")
    @ResponseBody
    public Result<Object> login(){

        // 生成并保存state 忽略该参数有可能导致CSRF攻击
        String state = String.valueOf(System.currentTimeMillis());
        redisTemplate.opsForValue().set(SecurityConstant.GITHUB_STATE + state, "VALID", 3L, TimeUnit.MINUTES);

        // 传递参数response_type、client_id、state、redirect_uri
        String url = AUTHORIZE_URL + "?response_type=code&" + "client_id=" + clientId + "&state=" + state
                + "&redirect_uri=" + callbackUrl;

        return ResultUtil.data(url);
    }

    @RequestMapping(value = "/callback", method = RequestMethod.GET)
    @ApiOperation(value = "获取accessToken")
    @SystemLog(description = "Github关联登录", type = LogType.LOGIN)
    public String getAccessToken(@RequestParam(required = false) String code,
                                 @RequestParam(required = false) String state) throws UnsupportedEncodingException {

        if(StrUtil.isBlank(code)){
            return "redirect:" + callbackFeUrl + "?error=" + URLEncoder.encode("您未同意授权","utf-8");
        }
        // 验证state
        String v = redisTemplate.opsForValue().get(SecurityConstant.GITHUB_STATE + state);
        redisTemplate.delete(SecurityConstant.GITHUB_STATE + state);
        if(StrUtil.isBlank(v)) {
            return "redirect:" + callbackFeUrl + "?error=" + URLEncoder.encode("授权超时或state不正确","utf-8");
        }

        // 传递参数grant_type、code、redirect_uri、client_id
        String params = "grant_type=authorization_code&code=" + code + "&redirect_uri=" +
                callbackUrl + "&client_id=" + clientId + "&client_secret=" + clientSecret;

        // 申请令牌 post请求
        String result = HttpUtil.post(ACCESS_TOKEN_URL, params);

        if(!result.contains("access_token=")){
            return "redirect:" + callbackFeUrl + "?error=" + URLEncoder.encode("获取access_token失败","utf-8");
        }

        String accessToken = StrUtil.subBetween(result,"access_token=", "&scope");
        // 获取用户信息
        String userInfo = HttpUtil.get(GET_USERINFO_URL + accessToken);
        GithubUserInfo gu = new Gson().fromJson(userInfo, GithubUserInfo.class);
        // 存入数据库
        Social github = socialService.findByOpenIdAndPlatform(gu.getId(), CommonConstant.SOCIAL_TYPE_GITHUB);
        if(github==null){
            Social g = new Social().setOpenId(gu.getId()).setUsername(gu.getLogin()).setAvatar(gu.getAvatar_url()).setPlatform(CommonConstant.SOCIAL_TYPE_GITHUB);
            github = socialService.save(g);
        }

        String url = "";
        // 判断是否绑定账号
        if(StrUtil.isNotBlank(github.getRelateUsername())){
            // 已绑定 直接登录
            String JWT = securityUtil.getToken(github.getRelateUsername(), true);
            // 存入redis
            String JWTKey = UUID.randomUUID().toString().replace("-","");
            redisTemplate.opsForValue().set(JWTKey, JWT, 2L, TimeUnit.MINUTES);
            url = callbackFeUrl + "?related=1&JWTKey=" + JWTKey;
            // 记录日志使用
            UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
                    new SecurityUserDetails(new User().setUsername(github.getRelateUsername())), null, null);
            SecurityContextHolder.getContext().setAuthentication(authentication);
        }else{
            // 未绑定 Redis存入id
            String idToken = UUID.randomUUID().toString().replace("-","");
            redisTemplate.opsForValue().set(idToken, github.getId(), 5L, TimeUnit.MINUTES);
            url = callbackFeRelateUrl + "?socialType="+ CommonConstant.SOCIAL_TYPE_GITHUB +"&id=" + idToken;
        }
        return "redirect:" + url;
    }
}
