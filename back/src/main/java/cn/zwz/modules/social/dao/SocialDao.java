package cn.zwz.modules.social.dao;

import cn.zwz.base.XbootBaseDao;
import cn.zwz.modules.social.entity.Social;

import java.util.List;

/**
 * Github登录数据处理层
 * @author 郑为中
 */
public interface SocialDao extends XbootBaseDao<Social, String> {

    /**
     * 通过openId和平台获取
     * @param openId
     * @param platform
     * @return
     */
    Social findByOpenIdAndPlatform(String openId, Integer platform);

    /**
     * 通过userId和平台获取
     * @param relateUsername
     * @param platform
     * @return
     */
    Social findByRelateUsernameAndPlatform(String relateUsername, Integer platform);

    /**
     * 通过relateUsername获取
     * @param relateUsername
     * @return
     */
    List<Social> findByRelateUsername(String relateUsername);
}