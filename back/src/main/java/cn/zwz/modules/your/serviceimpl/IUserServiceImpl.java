package cn.zwz.modules.your.serviceimpl;

import cn.zwz.modules.base.entity.User;
import cn.zwz.modules.your.mapper.UserMapper;
import cn.zwz.modules.your.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 账单接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class IUserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    @Autowired
    private UserMapper userMapper;
}