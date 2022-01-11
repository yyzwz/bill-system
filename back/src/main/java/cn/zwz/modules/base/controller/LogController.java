package cn.zwz.modules.base.controller;

import cn.zwz.common.utils.PageUtil;
import cn.zwz.common.utils.ResultUtil;
import cn.zwz.common.vo.PageVo;
import cn.zwz.common.vo.Result;
import cn.zwz.common.vo.SearchVo;
import cn.zwz.modules.base.service.LogService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

/**
 * @author 郑为中
 */
@RestController
@Api(description = "日志管理")
@RequestMapping("/zwz/log")
@Transactional
public class LogController{

    @Autowired
    private LogService logService;

    @RequestMapping(value = "/getAllByPage", method = RequestMethod.GET)
    @ApiOperation(value = "查询日志")
    public Result<Object> getAllByPage(@RequestParam(required = false) Integer type,@RequestParam String key,SearchVo searchVo,PageVo pageVo){
        return ResultUtil.data(logService.findByConfition(type, key, searchVo, PageUtil.initPage(pageVo)));
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "删除日志")
    public Result<Object> delByIds(@RequestParam String[] ids){
        for(String id : ids){
            logService.delete(id);
        }
        return ResultUtil.success();
    }

    @RequestMapping(value = "/delAll", method = RequestMethod.POST)
    @ApiOperation(value = "删除全部日志")
    public Result<Object> delAll(){
        logService.deleteAll();
        return ResultUtil.success();
    }
}
