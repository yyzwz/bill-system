package cn.zwz.modules.your.serviceimpl;

import cn.zwz.modules.your.mapper.SupplierMapper;
import cn.zwz.modules.your.entity.Supplier;
import cn.zwz.modules.your.service.ISupplierService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 供应商接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class ISupplierServiceImpl extends ServiceImpl<SupplierMapper, Supplier> implements ISupplierService {

    @Autowired
    private SupplierMapper supplierMapper;
}