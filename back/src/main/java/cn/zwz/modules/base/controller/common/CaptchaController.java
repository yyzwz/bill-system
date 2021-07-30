package cn.zwz.modules.base.controller.common;

import cn.zwz.common.constant.CommonConstant;
import cn.zwz.common.utils.*;
import cn.zwz.common.vo.Result;
import cn.zwz.modules.base.entity.Setting;
import cn.zwz.modules.base.service.SettingService;
import cn.zwz.modules.base.service.UserService;
import cn.hutool.core.util.StrUtil;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * @author 郑为中
 */
@Api(description = "验证码接口")
@RequestMapping("/xboot/common/captcha")
@RestController
@Transactional
@Slf4j
public class CaptchaController {

    @Autowired
    private SmsUtil smsUtil;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @Autowired
    private IpInfoUtil ipInfoUtil;

    @Autowired
    private UserService userService;

    @Autowired
    private SettingService settingService;

    @RequestMapping(value = "/init", method = RequestMethod.GET)
    @ApiOperation(value = "初始化验证码")
    public Result<Object> initCaptcha() {

        String captchaId = UUID.randomUUID().toString().replace("-","");
        String code = new CreateVerifyCode().randomStr(4);
        // 缓存验证码
        redisTemplate.opsForValue().set(captchaId, code,2L, TimeUnit.MINUTES);
        return ResultUtil.data(captchaId);
    }

    @RequestMapping(value = "/draw/{captchaId}", method = RequestMethod.GET)
    @ApiOperation(value = "根据验证码ID获取图片")
    public void drawCaptcha(@PathVariable("captchaId") String captchaId,
                            HttpServletResponse response) throws IOException {

        // 得到验证码 生成指定验证码
        String code = redisTemplate.opsForValue().get(captchaId);
        CreateVerifyCode vCode = new CreateVerifyCode(116,36,4,10, code);
        response.setContentType("image/png");
        vCode.write(response.getOutputStream());
    }

    @RequestMapping(value = "/sendRegistSms/{mobile}", method = RequestMethod.GET)
    @ApiOperation(value = "发送注册短信验证码")
    public Result<Object> sendRegistSmsCode(@PathVariable String mobile, HttpServletRequest request) {

        return sendSms(mobile, 0, 0, request);
    }

    @RequestMapping(value = "/sendLoginSms/{mobile}", method = RequestMethod.GET)
    @ApiOperation(value = "发送登录短信验证码")
    public Result<Object> sendLoginSmsCode(@PathVariable String mobile, HttpServletRequest request) {

        return sendSms(mobile, 1, 0, request);
    }

    @RequestMapping(value = "/sendResetSms/{mobile}", method = RequestMethod.GET)
    @ApiOperation(value = "发送重置密码短信验证码")
    public Result<Object> sendResetSmsCode(@PathVariable String mobile, HttpServletRequest request) {

        return sendSms(mobile, 1, 1, request);
    }

    @RequestMapping(value = "/sendEditMobileSms/{mobile}", method = RequestMethod.GET)
    @ApiOperation(value = "发送修改手机短信验证码")
    public Result<Object> sendEditMobileSmsCode(@PathVariable String mobile, HttpServletRequest request) {

        if(userService.findByMobile(mobile)!=null){
            return ResultUtil.error("该手机号已绑定账户");
        }
        return sendSms(mobile, 0, 0, request);
    }

    /**
     *
     * @param mobile 手机号
     * @param range 发送范围 0发送给所有手机号 1只发送给注册手机
     * @param template 0通用模版 1重置密码模版
     */
    public Result<Object> sendSms(String mobile, Integer range, Integer template, HttpServletRequest request){

        if(range==1&&userService.findByMobile(mobile)==null){
            return ResultUtil.error("手机号未注册");
        }
        // IP限流 1分钟限1个请求
        String key = "sendSms:"+ipInfoUtil.getIpAddr(request);
        String value = redisTemplate.opsForValue().get(key);
        if (StrUtil.isNotBlank(value)) {
            return ResultUtil.error("您发送的太频繁啦，请稍后再试");
        }
        // 生成6位数验证码
        String code = CommonUtil.getRandomNum();
        // 缓存验证码
        redisTemplate.opsForValue().set(CommonConstant.PRE_SMS + mobile, code,5L, TimeUnit.MINUTES);
        // 发送验证码
        try {
            // 获取模板
            Setting setting = settingService.get(CommonUtil.getSmsTemplate(template));
            if(StrUtil.isBlank(setting.getValue())){
                return ResultUtil.error("系统还未配置短信服务或通用模版");
            }
            SendSmsResponse response = smsUtil.sendCode(mobile, code, setting.getValue());
            if(response.getCode() != null && ("OK").equals(response.getMessage())) {
                // 请求成功 标记限流
                redisTemplate.opsForValue().set(key, "sended", 1L, TimeUnit.MINUTES);
                return ResultUtil.success("发送短信验证码成功");
            }else{
                return ResultUtil.error("请求发送验证码失败，" + response.getMessage());
            }
        } catch (ClientException e) {
            log.error("请求发送短信验证码失败，" + e);
            return ResultUtil.error("请求发送验证码失败，" + e.getMessage());
        }
    }
}
