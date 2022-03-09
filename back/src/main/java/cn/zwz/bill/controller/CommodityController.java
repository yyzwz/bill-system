package cn.zwz.bill.controller;

import cn.hutool.core.util.StrUtil;
import cn.zwz.basics.baseVo.PageVo;
import cn.zwz.basics.baseVo.Result;
import cn.zwz.basics.utils.PageUtil;
import cn.zwz.basics.utils.ResultUtil;
import cn.zwz.bill.entity.Commodity;
import cn.zwz.bill.entity.Supplier;
import cn.zwz.bill.service.ICommodityService;
import cn.zwz.bill.service.ISupplierService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author 郑为中
 */
@RestController
@Api(tags = "商品管理")
@RequestMapping("/zwz/commodity")
@Transactional
public class CommodityController {

    @Autowired
    private ICommodityService iCommodityService;

    @Autowired
    private ISupplierService iSupplierService;

    @RequestMapping(value = "/get", method = RequestMethod.GET)
    @ApiOperation(value = "查询单个商品")
    public Result<Commodity> get(@RequestParam String id){
        Commodity commodity = iCommodityService.getById(id);
        return new ResultUtil<Commodity>().setData(commodity);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "查询全部商品")
    public Result<List<Commodity>> getAll(){
        List<Commodity> list = iCommodityService.list();
        return new ResultUtil<List<Commodity>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "查询商品")
    public Result<IPage<Commodity>> getByPage(@ModelAttribute Commodity commodity, @ModelAttribute PageVo page){
        QueryWrapper<Commodity> qw = new QueryWrapper<>();
        if(StrUtil.isNotBlank(commodity.getName())) {
            qw.eq("name",commodity.getName());
        }
        if(StrUtil.isNotBlank(commodity.getType())) {
            qw.eq("type",commodity.getType());
        }
        if(StrUtil.isNotBlank(commodity.getStock())) {
            qw.eq("stock",commodity.getStock());
        }
        if(StrUtil.isNotBlank(commodity.getSupplierId())) {
            qw.eq("supplier_id",commodity.getSupplierId());
        }
        if(StrUtil.isNotBlank(commodity.getUnitPrice())) {
            qw.eq("unit_price",commodity.getUnitPrice());
        }
        IPage<Commodity> data = iCommodityService.page(PageUtil.initMpPage(page),qw);
        for (Commodity com : data.getRecords()) {
            Supplier supplier = iSupplierService.getById(com.getSupplierId());
            if(supplier != null) {
                com.setSupplierName(supplier.getName());
            }
        }
        return new ResultUtil<IPage<Commodity>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "增改商品")
    public Result<Commodity> saveOrUpdate(Commodity commodity){
        if(iCommodityService.saveOrUpdate(commodity)){
            return new ResultUtil<Commodity>().setData(commodity);
        }
        return new ResultUtil<Commodity>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "删除商品")
    public Result<Object> delAllByIds(@RequestParam String[] ids){
        for(String id : ids){
            iCommodityService.removeById(id);
        }
        return ResultUtil.success();
    }
}
