 package cn.zwz.modules.app.dao;

import cn.zwz.base.XbootBaseDao;
import cn.zwz.modules.app.entity.Member;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
 * 会员数据处理层
 * @author 郑为中
 */
public interface MemberDao extends XbootBaseDao<Member, String> {

    /**
     * 通过用户名获取用户
     * @param username
     * @return
     */
    Member findByUsername(String username);

    /**
     * 通过手机获取用户
     * @param mobile
     * @return
     */
    Member findByMobile(String mobile);
}