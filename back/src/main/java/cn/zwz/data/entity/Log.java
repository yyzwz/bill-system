package cn.zwz.data.entity;

import cn.hutool.core.util.StrUtil;
import cn.zwz.basics.baseClass.ZwzBaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import com.google.gson.Gson;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiOperation;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.HashMap;
import java.util.Map;

/**
 * @author 郑为中
 */
@Data
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "t_log")
@TableName("t_log")
@ApiModel(value = "日志")
public class Log extends ZwzBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "日志标题")
    private String name;

    @ApiModelProperty(value = "日志类型")
    private Integer logType;

    @ApiModelProperty(value = "请求URL")
    private String requestUrl;

    @ApiModelProperty(value = "请求方式")
    private String requestType;

    @ApiModelProperty(value = "参数")
    private String requestParam;

    @ApiModelProperty(value = "触发者")
    private String username;

    @ApiModelProperty(value = "IP地址")
    private String ip;

    @ApiModelProperty(value = "IP定位")
    private String ipInfo;

    @ApiModelProperty(value = "消耗毫秒数")
    private Integer costTime;

    @ApiOperation(value = "MAP转换为字符串")
    public static String mapToString(Map<String, String[]> paramMap){
        if (paramMap == null) {
            return "";
        }
        Map<String, Object> params = new HashMap<>(16);
        for (Map.Entry<String, String[]> keyInMap : paramMap.entrySet()) {
            String keyItemInMap = keyInMap.getKey();
            String paramValue = (keyInMap.getValue() != null && keyInMap.getValue().length > 0 ? keyInMap.getValue()[0] : "");
            String objStr = StrUtil.endWithIgnoreCase(keyInMap.getKey(), "password") ? "密码隐藏" : paramValue;
            params.put(keyItemInMap, objStr);
        }
        return new Gson().toJson(params);
    }

    @ApiOperation(value = "Map转换为JSON数据")
    public void setMapToParams(Map<String, String[]> paramMap) {
        this.requestParam = mapToString(paramMap);
    }
}
