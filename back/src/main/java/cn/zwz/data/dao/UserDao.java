package cn.zwz.data.dao;

import cn.zwz.basics.baseClass.ZwzBaseDao;
import cn.zwz.data.entity.User;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * 用户数据处理层
 * @author 郑为中
 */
public interface UserDao extends ZwzBaseDao<User,String> {

    /**
     * 通过用户名获取用户
     * @param username
     * @return
     */
    User findByUsername(String username);

    /**
     * 通过手机获取用户
     * @param mobile
     * @return
     */
    User findByMobile(String mobile);
}
