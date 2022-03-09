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
@Table(name = "t_bill")
@TableName("t_bill")
@ApiModel(value = "账单")
public class Bill extends ZwzBaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "供应商ID")
    private String supplierId;

    @Transient
    @TableField(exist=false)
    @ApiModelProperty(value = "供应商名")
    private String supplierName;

    @ApiModelProperty(value = "商品ID")
    private String commodityId;

    @Transient
    @TableField(exist=false)
    @ApiModelProperty(value = "商品名")
    private String commodityName;

    @ApiModelProperty(value = "负责员工Id")
    private String userId;

    @Transient
    @TableField(exist=false)
    @ApiModelProperty(value = "负责员工姓名")
    private String userName;

    @ApiModelProperty(value = "数量")
    private String number;

    @ApiModelProperty(value = "单价")
    private String price;

    @ApiModelProperty(value = "总价")
    private String sum;

    @ApiModelProperty(value = "进货时间")
    private String dateTime;
}