package cn.zwz.modules.base.controller.manage;

import cn.zwz.base.XbootBaseController;
import cn.zwz.common.utils.PageUtil;
import cn.zwz.common.utils.ResultUtil;
import cn.zwz.common.vo.PageVo;
import cn.zwz.common.vo.Result;
import cn.zwz.modules.base.entity.Message;
import cn.zwz.modules.base.entity.MessageSend;
import cn.zwz.modules.base.entity.User;
import cn.zwz.modules.base.service.MessageSendService;
import cn.zwz.modules.base.service.MessageService;
import cn.zwz.modules.base.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;


/**
 * @author 郑为中
 */
@Slf4j
@RestController
@Api(description = "消息发送管理接口")
@RequestMapping("/xboot/messageSend")
@Transactional
public class MessageSendController extends XbootBaseController<MessageSend, String> {

    @Autowired
    private UserService userService;

    @Autowired
    private MessageService messageService;

    @Autowired
    private MessageSendService messageSendService;

    @Override
    public MessageSendService getService() {
        return messageSendService;
    }

    @RequestMapping(value = "/getByCondition", method = RequestMethod.GET)
    @ApiOperation(value = "多条件分页获取")
    public Result<Page<MessageSend>> getByCondition(MessageSend ms,
                                                    PageVo pv){

        Page<MessageSend> page = messageSendService.findByCondition(ms, PageUtil.initPage(pv));
        // lambda
        page.getContent().forEach(item->{
            User u = userService.get(item.getUserId());
            if(u!=null){
                item.setUsername(u.getUsername()).setNickname(u.getNickname());
            }
            Message m = messageService.get(item.getMessageId());
            item.setTitle(m.getTitle()).setContent(m.getContent()).setType(m.getType());
        });
        return new ResultUtil<Page<MessageSend>>().setData(page);
    }
}
