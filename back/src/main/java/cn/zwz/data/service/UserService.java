package cn.zwz.data.service;

import cn.zwz.basics.baseClass.ZwzBaseService;
import cn.zwz.data.entity.User;
import io.swagger.annotations.ApiOperation;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;

/**
 * 用户服务层
 * @author 郑为中
 */
@CacheConfig(cacheNames = "user")
public interface UserService extends ZwzBaseService<User,String> {

    @ApiOperation(value = "账号查询")
    @Cacheable(key = "#username")
    User findByUsername(String username);

    @ApiOperation(value = "手机号查询")
    User findByMobile(String mobile);
}
