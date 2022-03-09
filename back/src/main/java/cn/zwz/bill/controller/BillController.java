package cn.zwz.bill.controller;

import cn.zwz.basics.baseVo.PageVo;
import cn.zwz.basics.baseVo.Result;
import cn.zwz.basics.utils.PageUtil;
import cn.zwz.basics.utils.ResultUtil;
import cn.zwz.basics.utils.SecurityUtil;
import cn.zwz.bill.entity.Bill;
import cn.zwz.bill.entity.Commodity;
import cn.zwz.bill.entity.Supplier;
import cn.zwz.bill.service.IBillService;
import cn.zwz.bill.service.ICommodityService;
import cn.zwz.bill.service.ISupplierService;
import cn.zwz.bill.utils.DateUtils;
import cn.zwz.data.entity.User;
import cn.zwz.data.service.IUserService;
import cn.zwz.data.utils.ZwzNullUtils;
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
@Api(tags = "账单管理")
@RequestMapping("/zwz/bill")
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

    @RequestMapping(value = "/get", method = RequestMethod.GET)
    @ApiOperation(value = "查询单个账单")
    public Result<Bill> get(@RequestParam String id){
        Bill bill = iBillService.getById(id);
        return new ResultUtil<Bill>().setData(bill);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "查询全部账单")
    public Result<List<Bill>> getAll(){
        List<Bill> list = iBillService.list();
        return new ResultUtil<List<Bill>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "查询账单")
    public Result<IPage<Bill>> getByPage(@ModelAttribute Bill bill, @ModelAttribute PageVo page){
        QueryWrapper<Bill> qw = new QueryWrapper<>();
        if(!ZwzNullUtils.isNull(bill.getUserId())) {
            qw.eq("user_id",bill.getUserId());
        }
        if(!ZwzNullUtils.isNull(bill.getCommodityId())) {
            qw.eq("commodity_id",bill.getCommodityId());
        }
        if(!ZwzNullUtils.isNull(bill.getSupplierId())) {
            qw.eq("supplier_id",bill.getSupplierId());
        }
        IPage<Bill> data = iBillService.page(PageUtil.initMpPage(page),qw);
        for (Bill bill1 : data.getRecords()) {
            Supplier supplier = iSupplierService.getById(bill1.getSupplierId());
            if(supplier != null) {
                bill1.setSupplierName(supplier.getName());
            } else {
                bill1.setSupplierName("无");
            }
            Commodity commodity = iCommodityService.getById(bill1.getCommodityId());
            if(commodity != null) {
                bill1.setCommodityName(commodity.getName());
            } else {
                bill1.setCommodityName("无");
            }
            User user = iUserService.getById(bill1.getUserId());
            if(user != null) {
                bill1.setUserName(user.getNickname());
            } else {
                bill1.setUserName("无");
            }
        }
        return new ResultUtil<IPage<Bill>>().setData(data);
    }

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ApiOperation(value = "新增账单")
    public Result<Bill> insert(Bill bill) {
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
        return new ResultUtil<Bill>().setErrorMsg("新增账单失败");
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ApiOperation(value = "编辑账单")
    public Result<Bill> update(Bill bill) {
        if(iBillService.saveOrUpdate(bill)){
            return new ResultUtil<Bill>().setData(bill);
        }
        return new ResultUtil<Bill>().setErrorMsg("编辑账单失败");
    }
    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "删除账单")
    public Result<Object> delAllByIds(@RequestParam String[] ids) {
        for(String id : ids){
            iBillService.removeById(id);
        }
        return ResultUtil.success();
    }
}
