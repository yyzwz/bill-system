package cn.zwz.modules.open.service;

import cn.zwz.base.XbootBaseService;
import cn.zwz.modules.open.entity.Client;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import cn.zwz.common.vo.SearchVo;

import java.util.List;

/**
 * 客户端接口
 * @author 郑为中
 */
public interface ClientService extends XbootBaseService<Client,String> {

    /**
    * 多条件分页获取
    * @param client
    * @param searchVo
    * @param pageable
    * @return
    */
    Page<Client> findByCondition(Client client, SearchVo searchVo, Pageable pageable);

}