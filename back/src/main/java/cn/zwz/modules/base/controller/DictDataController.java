package cn.zwz.modules.base.controller;

import cn.zwz.common.utils.PageUtil;
import cn.zwz.common.utils.ResultUtil;
import cn.zwz.common.vo.PageVo;
import cn.zwz.common.vo.Result;
import cn.zwz.modules.base.entity.Dict;
import cn.zwz.modules.base.entity.DictData;
import cn.zwz.modules.base.service.DictDataService;
import cn.zwz.modules.base.service.DictService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author 郑为中
 */
@RestController
@Api(description = "字典数据")
@RequestMapping("/zwz/dictData")
@CacheConfig(cacheNames = "dictData")
@Transactional
public class DictDataController{

    @Autowired
    private DictService dictService;

    @Autowired
    private DictDataService dictDataService;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @RequestMapping(value = "/getByCondition", method = RequestMethod.GET)
    @ApiOperation(value = "查询数据字典的值")
    public Result<Page<DictData>> getByCondition(DictData dictData,PageVo pageVo){
        return new ResultUtil<Page<DictData>>().setData(dictDataService.findByCondition(dictData, PageUtil.initPage(pageVo)));
    }

    @RequestMapping(value = "/getByType/{type}", method = RequestMethod.GET)
    @ApiOperation(value = "查询单个数据字典的值")
    @Cacheable(key = "#type")
    public Result<Object> getByType(@PathVariable String type){
        Dict dict = dictService.findByType(type);
        if (dict == null) {
            return ResultUtil.error("字典类型 "+ type +" 不存在");
        }
        List<DictData> list = dictDataService.findByDictId(dict.getId());
        return ResultUtil.data(list);
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ApiOperation(value = "添加数据字典的值")
    public Result<Object> add(DictData dictData){
        Dict dict = dictService.get(dictData.getDictId());
        if (dict == null) {
            return ResultUtil.error("字典类型id不存在");
        }
        dictDataService.save(dictData);
        redisTemplate.delete("dictData::"+dict.getType());
        return ResultUtil.success();
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ApiOperation(value = "编辑数据字典的值")
    public Result<Object> edit(DictData dictData){

        dictDataService.update(dictData);
        // 删除缓存
        Dict dict = dictService.get(dictData.getDictId());
        redisTemplate.delete("dictData::"+dict.getType());
        return ResultUtil.success();
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "删除数据字典的值")
    public Result<Object> delByIds(@RequestParam String[] ids){
        for(String id : ids){
            DictData dictData = dictDataService.get(id);
            Dict dict = dictService.get(dictData.getDictId());
            dictDataService.delete(id);
            redisTemplate.delete("dictData::"+dict.getType());
        }
        return ResultUtil.success();
    }
}
