package cn.zwz.modules.base.controller;

import cn.zwz.common.utils.ResultUtil;
import cn.zwz.common.vo.Result;
import cn.zwz.modules.base.entity.Dict;
import cn.zwz.modules.base.service.DictDataService;
import cn.zwz.modules.base.service.DictService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author 郑为中
 */
@RestController
@Api(description = "字典管理接口")
@RequestMapping("/zwz/dict")
@Transactional
public class DictController {

    @Autowired
    private DictService dictService;

    @Autowired
    private DictDataService dictDataService;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "查询数据字典")
    public Result<List<Dict>> getAll(){
        return new ResultUtil<List<Dict>>().setData(dictService.findAllOrderBySortOrder());
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ApiOperation(value = "添加数据字典")
    public Result<Object> add(Dict dict){
        if(dictService.findByType(dict.getType())!=null){
            return ResultUtil.error("字典类型已存在");
        }
        dictService.save(dict);
        return ResultUtil.success();
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ApiOperation(value = "编辑数据字典")
    public Result<Object> edit(Dict dict){
        Dict old = dictService.get(dict.getId());
        if(!old.getType().equals(dict.getType())&&dictService.findByType(dict.getType())!=null){
            return ResultUtil.error("字典类型已存在");
        }
        dictService.update(dict);
        return ResultUtil.success();
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "删除数据字典")
    public Result<Object> delAllByIds(@RequestParam String[] ids){
        for (String id : ids){
            Dict dict = dictService.get(id);
            dictService.delete(id);
            dictDataService.deleteByDictId(id);
            redisTemplate.delete("dictData::"+dict.getType());
        }
        return ResultUtil.success();
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    @ApiOperation(value = "搜索数据字典")
    public Result<List<Dict>> search(@RequestParam String key){
        return new ResultUtil<List<Dict>>().setData(dictService.findByTitleOrTypeLike(key));
    }
}
