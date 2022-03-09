package cn.zwz.basics.log;

import cn.zwz.basics.utils.IpInfoUtil;
import cn.zwz.basics.utils.ThreadPoolUtil;
import cn.zwz.data.entity.Log;
import cn.zwz.data.service.LogService;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NamedThreadLocal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

/**
 * Spring AOP实现日志管理
 * @author 郑为中
 */
@Aspect
@Component
@Slf4j
public class SystemLogAspect {

    private static final ThreadLocal<Date> beginTimeThreadLocal = new NamedThreadLocal<Date>("ThreadLocal beginTime");

    @Autowired
    private LogService logService;

    @Autowired(required = false)
    private HttpServletRequest request;

    @Autowired
    private IpInfoUtil ipInfoUtil;

    @ApiOperation(value = "控制层切点")
    @Pointcut("@annotation(cn.zwz.basics.log.SystemLog)")
    public void controllerAspect() {

    }

    @ApiOperation(value = "前置通知")
    @Before("controllerAspect()")
    public void doBefore(JoinPoint joinPoint){
        Date beginTime = new Date();
        beginTimeThreadLocal.set(beginTime);
    }

    @ApiOperation(value = "后置通知")
    @AfterReturning("controllerAspect()")
    public void after(JoinPoint joinPoint){
        try {
            String username = null;
            String description = getControllerMethodInfo(joinPoint).get("description").toString();
            int type = (int)getControllerMethodInfo(joinPoint).get("type");
            Map<String, String[]> logParams = request.getParameterMap();
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            if(Objects.equals("anonymousUser",principal.toString())){
                return;
            }
            UserDetails user = (UserDetails) principal;
            username = user.getUsername();
            Log log = new Log();
            // 请求用户
            log.setUsername(username);
            // 日志标题
            log.setName(description);
            // 日志类型
            log.setLogType(type);
            // 日志请求url
            log.setRequestUrl(request.getRequestURI());
            // 请求方式
            log.setRequestType(request.getMethod());
            // 请求参数
            log.setMapToParams(logParams);
            // 请求IP
            log.setIp(ipInfoUtil.getIpAddr(request));
            // IP定位
            log.setIpInfo(ipInfoUtil.getIpCity(request));
            // 请求开始时间
            long beginTime = beginTimeThreadLocal.get().getTime();
            long endTime = System.currentTimeMillis();
            // 请求耗时
            Long logElapsedTime = endTime - beginTime;
            log.setCostTime(logElapsedTime.intValue());
            // 保存日志
            ThreadPoolUtil.getPool().execute(new SaveSystemLogThread(log, logService));

        } catch (Exception e) {
            log.warn("日志记录失败", e);
        }
    }

    @ApiOperation(value = "保存日志")
    private static class SaveSystemLogThread implements Runnable {

        private Log log;
        private LogService logService;

        public SaveSystemLogThread(Log esLog, LogService logService) {
            this.log = esLog;
            this.logService = logService;
        }

        @Override
        public void run() {
            logService.save(log);
        }
    }

    public static Map<String, Object> getControllerMethodInfo(JoinPoint joinPoint) throws Exception{
        Map<String, Object> map = new HashMap<String, Object>(16);
        //获取目标类名
        String targetName = joinPoint.getTarget().getClass().getName();
        //获取方法名
        String methodName = joinPoint.getSignature().getName();
        //获取相关参数
        Object[] arguments = joinPoint.getArgs();
        //生成类对象
        Class targetClass = Class.forName(targetName);
        //获取该类中的方法
        Method[] methods = targetClass.getMethods();
        String description = "";
        Integer type = null;
        for(Method method : methods) {
            if(!method.getName().equals(methodName)) {
                continue;
            }
            Class[] clazzs = method.getParameterTypes();
            if(clazzs.length != arguments.length) {
                continue;
            }
            description = method.getAnnotation(SystemLog.class).about();
            type = method.getAnnotation(SystemLog.class).type().ordinal();
            map.put("description", description);
            map.put("type", type);
        }
        return map;
    }
}
