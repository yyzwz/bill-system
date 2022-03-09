package cn.zwz.data.serviceimpl;

import cn.zwz.basics.parameter.CommonConstant;
import cn.zwz.data.dao.UserDao;
import cn.zwz.data.dao.mapper.PermissionMapper;
import cn.zwz.data.dao.mapper.UserRoleMapper;
import cn.zwz.data.entity.Permission;
import cn.zwz.data.entity.Role;
import cn.zwz.data.entity.User;
import cn.zwz.data.service.UserService;
import cn.zwz.data.vo.PermissionDTO;
import cn.zwz.data.vo.RoleDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 用户接口实现
 * @author 郑为中
 */
@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private UserRoleMapper userRoleMapper;

    @Autowired
    private PermissionMapper permissionMapper;

    @Override
    public UserDao getRepository() {
        return userDao;
    }

    public User userToDTO(User dtoUser){
        // 角色
        List<Role> roleList = userRoleMapper.findByUserId(dtoUser.getId());
        List<RoleDTO> dtos = roleList.stream().map(e->{
            return new RoleDTO().setId(e.getId()).setName(e.getName());
        }).collect(Collectors.toList());
        dtoUser.setRoles(dtos);
        // 菜单
        List<Permission> permissionList = permissionMapper.findByUserId(dtoUser.getId());
        List<PermissionDTO> dtoList = permissionList.stream()
                .filter(e -> CommonConstant.PERMISSION_OPERATION.equals(e.getType()))
                .map(e->{ return new PermissionDTO().setTitle(e.getTitle()).setPath(e.getPath()); }).collect(Collectors.toList());
        dtoUser.setPermissions(dtoList);
        return dtoUser;
    }

    @Override
    public User findByMobile(String mobile) {
        User user = userDao.findByMobile(mobile);
        if(user==null){
            return null;
        }
        return userToDTO(user);
    }

    @Override
    public User findByUsername(String username) {
        User user = userDao.findByUsername(username);
        if(user==null){
            return null;
        }
        return userToDTO(user);
    }
}
