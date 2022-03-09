package cn.zwz.basics.security.permission;

import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.Iterator;
import java.util.Objects;

/**
 * 权限过滤类
 * @author 郑为中
 */
@Component
public class MyAccessDecisionManager implements AccessDecisionManager {

    @Override
    @ApiOperation(value = "判断用户有无访问权限")
    public void decide(Authentication ac, Object o, Collection<ConfigAttribute> configAttributes) throws AccessDeniedException, InsufficientAuthenticationException {
        if(configAttributes == null){
            return;
        }
        Iterator<ConfigAttribute> attributeIterator = configAttributes.iterator();
        while (attributeIterator.hasNext()){
            ConfigAttribute attribute = attributeIterator.next();
            for(GrantedAuthority authority : ac.getAuthorities()) {
                if(Objects.equals(attribute.getAttribute().trim(),authority.getAuthority())) {
                    return;
                }
            }
        }
        throw new AccessDeniedException("没有访问权限");
    }

    @Override
    @ApiOperation(value = "重写supports方法")
    public boolean supports(ConfigAttribute configAttribute) {
        return true;
    }

    @Override
    @ApiOperation(value = "重写supports方法")
    public boolean supports(Class<?> aClass) {
        return true;
    }
}
