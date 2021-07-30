package cn.zwz.modules.base.dao;

import cn.zwz.base.XbootBaseDao;
import cn.zwz.modules.base.entity.Message;

import java.util.List;

/**
 * 消息内容数据处理层
 * @author 郑为中
 */
public interface MessageDao extends XbootBaseDao<Message,String> {

    /**
     * 通过创建发送标识获取
     * @param createSend
     * @return
     */
    List<Message> findByCreateSend(Boolean createSend);
}