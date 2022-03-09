package cn.zwz.bill.serviceimpl;

import cn.zwz.bill.mapper.SupplierMapper;
import cn.zwz.bill.entity.Supplier;
import cn.zwz.bill.service.ISupplierService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 供应商接口实现
 * @author 郑为中
 */
@Service
@Transactional
public class ISupplierServiceImpl extends ServiceImpl<SupplierMapper, Supplier> implements ISupplierService {

    @Autowired
    private SupplierMapper supplierMapper;
}