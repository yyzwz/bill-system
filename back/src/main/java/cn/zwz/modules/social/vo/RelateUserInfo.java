package cn.zwz.modules.social.vo;

import lombok.Data;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * @author 郑为中
 */
@Data
@Accessors(chain = true)
public class RelateUserInfo implements Serializable{

    private String githubId;

    private Boolean github = false;

    private String githubUsername;

    private String qqId;

    private Boolean qq = false;

    private String qqUsername;

    private String weiboId;

    private Boolean weibo = false;

    private String weiboUsername;

    private String wechatId;

    private Boolean wechat = false;

    private String wechatUsername;
}
