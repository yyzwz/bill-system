package cn.zwz.modules.base.controller;

import cn.zwz.common.utils.*;
import cn.zwz.common.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * @author 郑为中
 */
@Api(description = "验证码")
@RequestMapping("/zwz/common/captcha")
@RestController
@Transactional
public class CaptchaController {

    @Autowired
    private StringRedisTemplate redisTemplate;

    @RequestMapping(value = "/init", method = RequestMethod.GET)
    @ApiOperation(value = "前端获取验证码")
    public Result<Object> init() {
        String captchaId = UUID.randomUUID().toString().replace("-","");
        String code = new CreateVerifyCode().randomStr(4);
        redisTemplate.opsForValue().set(captchaId, code,2L, TimeUnit.MINUTES);
        return ResultUtil.data(captchaId);
    }

    @RequestMapping(value = "/draw/{captchaId}", method = RequestMethod.GET)
    @ApiOperation(value = "前端验证码返回")
    public void draw(@PathVariable("captchaId") String captchaId,HttpServletResponse response) throws IOException {
        String code = redisTemplate.opsForValue().get(captchaId);
        CreateVerifyCode vCode = new CreateVerifyCode(116,36,4,10, code);
        response.setContentType("image/png");
        vCode.write(response.getOutputStream());
    }
}
