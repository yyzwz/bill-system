package cn.zwz.modules.app.controller.admin;

import cn.zwz.common.constant.MemberConstant;
import cn.zwz.common.exception.XbootException;
import cn.zwz.common.utils.*;
import cn.zwz.common.vo.PageVo;
import cn.zwz.common.vo.Result;
import cn.zwz.common.vo.SearchVo;
import cn.zwz.modules.app.entity.Member;
import cn.zwz.modules.app.service.MemberService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.data.domain.Page;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;


/**
 * @author 郑为中
 */
@Slf4j
@RestController
@Api(description = "会员管理接口")
@RequestMapping("/xboot/app/member")
@CacheConfig(cacheNames = "member")
@Transactional
public class MemberAdminController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @RequestMapping(value = "/getByCondition", method = RequestMethod.GET)
    @ApiOperation(value = "多条件分页获取")
    public Result<Page<Member>> getByCondition(Member member,
                                               SearchVo searchVo,
                                               PageVo pageVo){

        Page<Member> page = memberService.findByCondition(member, searchVo, PageUtil.initPage(pageVo));
        return new ResultUtil<Page<Member>>().setData(page);
    }

    @RequestMapping(value = "/admin/add", method = RequestMethod.POST)
    @ApiOperation(value = "添加用户")
    public Result<Object> add(@Valid Member m){

        if(memberService.findByMobile(m.getMobile())!=null){
            throw new XbootException("该手机号已被注册");
        }

        Long uid = SnowFlakeUtil.nextId();
        // Username/UID 邀请码
        m.setUsername(uid.toString()).setInviteCode(Long.toString(uid, 32).toUpperCase());

        Member member = memberService.save(m);
        return ResultUtil.success("添加成功");
    }

    @RequestMapping(value = "/admin/edit", method = RequestMethod.POST)
    @ApiOperation(value = "管理员修改资料",notes = "需要通过id获取原用户信息 需要username更新缓存")
    @CacheEvict(key = "#m.username")
    public Result<Object> edit(@Valid Member m){

        Member old = memberService.get(m.getId());

        m.setUsername(old.getUsername()).setPassword(old.getPassword());
        // 若修改了手机和邮箱判断是否唯一
        if(!old.getMobile().equals(m.getMobile())&&memberService.findByMobile(m.getMobile())!=null){
            return ResultUtil.error("该手机号已绑定其他账户");
        }

        memberService.update(m);
        return ResultUtil.success("修改成功");
    }

    @RequestMapping(value = "/admin/status", method = RequestMethod.POST)
    @ApiOperation(value = "后台禁用用户")
    public Result<Object> disable(@RequestParam String userId,
                                  @RequestParam Boolean enable){

        Member member = memberService.get(userId);
        if(member==null){
            return ResultUtil.error("会员不存在");
        }
        if(enable){
            member.setStatus(MemberConstant.MEMBER_STATUS_NORMAL);
        }else{
            member.setStatus(MemberConstant.MEMBER_STATUS_LOCK);
        }
        memberService.update(member);
        //手动更新缓存
        redisTemplate.delete("member::"+member.getUsername());
        return ResultUtil.success("操作成功");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过ids删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            Member m = memberService.get(id);
            // 删除相关缓存
            redisTemplate.delete("member::" + m.getUsername());
            memberService.delete(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }

}
