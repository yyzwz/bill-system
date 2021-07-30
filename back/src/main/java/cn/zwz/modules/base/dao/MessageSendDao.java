package cn.zwz.modules.base.dao;

import cn.zwz.base.XbootBaseDao;
import cn.zwz.modules.base.entity.MessageSend;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

/**
 * 消息发送数据处理层
 * @author 郑为中
 */
public interface MessageSendDao extends XbootBaseDao<MessageSend,String> {

    /**
     * 通过消息id删除
     * @param messageId
     */
    @Modifying
    @Query("delete from MessageSend m where m.messageId = ?1")
    void deleteByMessageId(String messageId);
}