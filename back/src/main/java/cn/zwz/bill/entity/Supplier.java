package cn.zwz.bill.entity;

import cn.zwz.basics.baseClass.ZwzBaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @author 郑为中
 */
@Data
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "t_supplier")
@TableName("t_supplier")
@ApiModel(value = "供应商")
public class Supplier extends ZwzBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "供应商名称")
    private String name;

    @ApiModelProperty(value = "供应商电话")
    private String mobile;

    @ApiModelProperty(value = "供应商地址")
    private String address;

    @ApiModelProperty(value = "供应商分类")
    private String type;
}