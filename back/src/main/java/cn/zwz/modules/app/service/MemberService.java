package cn.zwz.modules.app.service;

import cn.zwz.base.XbootBaseService;
import cn.zwz.modules.app.entity.Member;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import cn.zwz.common.vo.SearchVo;

import java.util.List;

/**
 * 会员接口
 * @author 郑为中
 */
@CacheConfig(cacheNames = "member")
public interface MemberService extends XbootBaseService<Member, String> {

    /**
    * 多条件分页获取
    * @param member
    * @param searchVo
    * @param pageable
    * @return
    */
    Page<Member> findByCondition(Member member, SearchVo searchVo, Pageable pageable);

    /**
     * 通过用户名获取用户
     * @param username
     * @return
     */
    @Cacheable(key = "#username")
    Member findByUsername(String username);

    /**
     * 通过手机获取用户
     * @param mobile
     * @return
     */
    Member findByMobile(String mobile);
}