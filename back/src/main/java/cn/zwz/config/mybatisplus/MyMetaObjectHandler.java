package cn.zwz.config.mybatisplus;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * 字段填充审计
 * @author 郑为中
 */
@Slf4j
@Component
public class MyMetaObjectHandler implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if(!"anonymousUser".equals(principal.toString())){
            UserDetails user = (UserDetails) principal;
            this.setFieldValByName("createBy", user.getUsername(), metaObject);
        }
        this.setFieldValByName("createTime", new Date(), metaObject);
    }

    @Override
    public void updateFill(MetaObject metaObject) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if(!"anonymousUser".equals(principal.toString())){
            UserDetails user = (UserDetails) principal;
            this.setFieldValByName("updateBy", user.getUsername(), metaObject);
        }
        this.setFieldValByName("updateTime", new Date(), metaObject);
    }
}

