package cn.zwz.data.serviceimpl;

import cn.zwz.data.dao.mapper.UserRoleMapper;
import cn.zwz.data.entity.Role;
import cn.zwz.data.entity.UserRole;
import cn.zwz.data.service.IUserRoleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 用户-角色关系 服务层实现
 * @author 郑为中
 */
@Service
public class IUserRoleServiceImpl extends ServiceImpl<UserRoleMapper, UserRole> implements IUserRoleService {

    @Autowired
    private UserRoleMapper userRoleMapper;

    @Override
    public List<Role> findByUserId(String userId) {

        return userRoleMapper.findByUserId(userId);
    }

    @Override
    public List<String> findDepIdsByUserId(String userId) {

        return userRoleMapper.findDepIdsByUserId(userId);
    }
}
