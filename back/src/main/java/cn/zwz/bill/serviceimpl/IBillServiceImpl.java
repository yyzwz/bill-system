package cn.zwz.bill.serviceimpl;

import cn.zwz.bill.mapper.BillMapper;
import cn.zwz.bill.entity.Bill;
import cn.zwz.bill.service.IBillService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 账单接口实现
 * @author 郑为中
 */
@Service
@Transactional
public class IBillServiceImpl extends ServiceImpl<BillMapper, Bill> implements IBillService {

    @Autowired
    private BillMapper billMapper;
}