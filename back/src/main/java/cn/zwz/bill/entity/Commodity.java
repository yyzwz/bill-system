package cn.zwz.bill.entity;

import cn.zwz.basics.baseClass.ZwzBaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * @author 郑为中
 */
@Data
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "t_commodity")
@TableName("t_commodity")
@ApiModel(value = "商品")
public class Commodity extends ZwzBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "商品名称")
    private String name;

    @ApiModelProperty(value = "商品单价")
    private String unitPrice;

    @ApiModelProperty(value = "库存")
    private String stock;

    @ApiModelProperty(value = "商品分类")
    private String type;

    @ApiModelProperty(value = "供应商ID")
    private String supplierId;

    @Transient
    @TableField(exist=false)
    @ApiModelProperty(value = "供应商名")
    private String supplierName;
}