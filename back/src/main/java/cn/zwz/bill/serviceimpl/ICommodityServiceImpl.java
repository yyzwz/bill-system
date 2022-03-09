package cn.zwz.bill.serviceimpl;

import cn.zwz.bill.mapper.CommodityMapper;
import cn.zwz.bill.entity.Commodity;
import cn.zwz.bill.service.ICommodityService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


/**
 * 商品接口实现
 * @author 郑为中
 */
@Service
@Transactional
public class ICommodityServiceImpl extends ServiceImpl<CommodityMapper, Commodity> implements ICommodityService {

    @Autowired
    private CommodityMapper commodityMapper;
}