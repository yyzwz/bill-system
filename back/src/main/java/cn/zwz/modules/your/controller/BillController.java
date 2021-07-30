package cn.zwz.modules.your.controller;

import cn.zwz.common.utils.PageUtil;
import cn.zwz.common.utils.ResultUtil;
import cn.zwz.common.utils.SecurityUtil;
import cn.zwz.common.vo.PageVo;
import cn.zwz.common.vo.Result;
import cn.zwz.modules.base.entity.User;
import cn.zwz.modules.your.entity.Bill;
import cn.zwz.modules.your.entity.Commodity;
import cn.zwz.modules.your.entity.Supplier;
import cn.zwz.modules.your.service.IBillService;
import cn.zwz.modules.your.service.ICommodityService;
import cn.zwz.modules.your.service.ISupplierService;
import cn.zwz.modules.your.service.IUserService;
import cn.zwz.modules.your.utils.DateUtils;
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
@Api(description = "账单管理接口")
@RequestMapping("/xboot/bill")
@Transactional
public class BillController {

    @Autowired
    private IBillService iBillService;

    @Autowired
    private SecurityUtil securityUtil;

    @Autowired
    private ICommodityService iCommodityService;

    @Autowired
    private ISupplierService iSupplierService;

    @Autowired
    private IUserService iUserService;

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<Bill> get(@PathVariable String id){

        Bill bill = iBillService.getById(id);
        return new ResultUtil<Bill>().setData(bill);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<Bill>> getAll(){

        List<Bill> list = iBillService.list();
        return new ResultUtil<List<Bill>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<Bill>> getByPage(@ModelAttribute Bill bill, @ModelAttribute PageVo page){
        QueryWrapper<Bill> qw = new QueryWrapper<>();
        if(StrUtil.isNotBlank(bill.getUserId())) {
            qw.eq("user_id",bill.getUserId());
        }
        if(StrUtil.isNotBlank(bill.getCommodityId())) {
            qw.eq("commodity_id",bill.getCommodityId());
        }
        if(StrUtil.isNotBlank(bill.getSupplierId())) {
            qw.eq("supplier_id",bill.getSupplierId());
        }
        IPage<Bill> data = iBillService.page(PageUtil.initMpPage(page),qw);
        for (Bill bill1 : data.getRecords()) {
            Supplier supplier = iSupplierService.getById(bill1.getSupplierId());
            if(supplier != null) {
                bill1.setSupplierName(supplier.getName());
            }
            Commodity commodity = iCommodityService.getById(bill1.getCommodityId());
            if(commodity != null) {
                bill1.setCommodityName(commodity.getName());
            }
            User user = iUserService.getById(bill1.getUserId());
            if(user != null) {
                bill1.setUserName(user.getNickname());
            }
        }
        return new ResultUtil<IPage<Bill>>().setData(data);
    }

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<Bill> insert(Bill bill){
        bill.setDateTime(DateUtils.getCompleteNowDate());
        bill.setUserId(securityUtil.getCurrUser().getId());
        String price = bill.getPrice();
        String number = bill.getNumber();
        Double sum = Double.parseDouble(price) * Double.parseDouble(number);
        sum = Math.ceil(sum * 10.0) / 10.0;
        bill.setSum(sum + "");
        if(iBillService.saveOrUpdate(bill)){
            return new ResultUtil<Bill>().setData(bill);
        }
        return new ResultUtil<Bill>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<Bill> update(Bill bill){

        if(iBillService.saveOrUpdate(bill)){
            return new ResultUtil<Bill>().setData(bill);
        }
        return new ResultUtil<Bill>().setErrorMsg("操作失败");
    }
    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iBillService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
