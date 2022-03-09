package cn.zwz.bill.controller;

import cn.hutool.core.util.StrUtil;
import cn.zwz.basics.baseVo.PageVo;
import cn.zwz.basics.baseVo.Result;
import cn.zwz.basics.utils.PageUtil;
import cn.zwz.basics.utils.ResultUtil;
import cn.zwz.bill.entity.Supplier;
import cn.zwz.bill.service.ISupplierService;
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
@Api(tags = "供应商管理接口")
@RequestMapping("/zwz/supplier")
@Transactional
public class SupplierController {

    @Autowired
    private ISupplierService iSupplierService;

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<Supplier> get(@PathVariable String id){

        Supplier supplier = iSupplierService.getById(id);
        return new ResultUtil<Supplier>().setData(supplier);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<Supplier>> getAll(){

        List<Supplier> list = iSupplierService.list();
        return new ResultUtil<List<Supplier>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<Supplier>> getByPage(@ModelAttribute Supplier supplier, @ModelAttribute PageVo page){

        QueryWrapper<Supplier> qw = new QueryWrapper<>();
        if(StrUtil.isNotBlank(supplier.getAddress())) {
            qw.eq("address",supplier.getAddress());
        }
        if(StrUtil.isNotBlank(supplier.getMobile())) {
            qw.eq("mobile",supplier.getMobile());
        }
        if(StrUtil.isNotBlank(supplier.getName())) {
            qw.eq("name",supplier.getName());
        }
        if(StrUtil.isNotBlank(supplier.getType())) {
            qw.eq("type",supplier.getType());
        }
        IPage<Supplier> data = iSupplierService.page(PageUtil.initMpPage(page),qw);
        return new ResultUtil<IPage<Supplier>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<Supplier> saveOrUpdate(Supplier supplier){

        if(iSupplierService.saveOrUpdate(supplier)){
            return new ResultUtil<Supplier>().setData(supplier);
        }
        return new ResultUtil<Supplier>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iSupplierService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
