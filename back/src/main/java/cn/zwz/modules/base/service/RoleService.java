package cn.zwz.modules.base.service;


import cn.zwz.base.XbootBaseService;
import cn.zwz.modules.base.entity.Role;

import java.util.List;

/**
 * 角色接口
 * @author 郑为中
 */
public interface RoleService extends XbootBaseService<Role,String> {

    /**
     * 获取默认角色
     * @param defaultRole
     * @return
     */
    List<Role> findByDefaultRole(Boolean defaultRole);
}
