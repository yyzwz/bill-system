package cn.zwz.modules.your.serviceimpl;

import cn.zwz.modules.your.mapper.CommodityMapper;
import cn.zwz.modules.your.entity.Commodity;
import cn.zwz.modules.your.service.ICommodityService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 商品接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class ICommodityServiceImpl extends ServiceImpl<CommodityMapper, Commodity> implements ICommodityService {

    @Autowired
    private CommodityMapper commodityMapper;
}