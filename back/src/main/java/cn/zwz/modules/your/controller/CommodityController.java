package cn.zwz.modules.your.controller;

import cn.zwz.common.utils.PageUtil;
import cn.zwz.common.utils.ResultUtil;
import cn.zwz.common.vo.PageVo;
import cn.zwz.common.vo.Result;
import cn.zwz.modules.your.entity.Commodity;
import cn.zwz.modules.your.entity.Supplier;
import cn.zwz.modules.your.service.ICommodityService;
import cn.zwz.modules.your.service.ISupplierService;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author 郑为中
 */
@Slf4j
@RestController
@Api(description = "商品管理接口")
@RequestMapping("/xboot/commodity")
@Transactional
public class CommodityController {

    @Autowired
    private ICommodityService iCommodityService;

    @Autowired
    private ISupplierService iSupplierService;

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<Commodity> get(@PathVariable String id){

        Commodity commodity = iCommodityService.getById(id);
        return new ResultUtil<Commodity>().setData(commodity);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<Commodity>> getAll(){

        List<Commodity> list = iCommodityService.list();
        return new ResultUtil<List<Commodity>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<Commodity>> getByPage(@ModelAttribute Commodity commodity,@ModelAttribute PageVo page){
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
    @ApiOperation(value = "编辑或更新数据")
    public Result<Commodity> saveOrUpdate(Commodity commodity){

        if(iCommodityService.saveOrUpdate(commodity)){
            return new ResultUtil<Commodity>().setData(commodity);
        }
        return new ResultUtil<Commodity>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iCommodityService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
