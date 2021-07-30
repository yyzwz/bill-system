package cn.zwz.modules.your.serviceimpl;

import cn.zwz.modules.your.mapper.BillMapper;
import cn.zwz.modules.your.entity.Bill;
import cn.zwz.modules.your.service.IBillService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 账单接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class IBillServiceImpl extends ServiceImpl<BillMapper, Bill> implements IBillService {

    @Autowired
    private BillMapper billMapper;
}