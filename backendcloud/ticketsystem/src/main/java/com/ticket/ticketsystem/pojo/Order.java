package com.ticket.ticketsystem.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
/**
 * @author: VenusHui
 * @description: TODO
 * @date: 2022/12/20 14:51
 * @version: 1.0
 */
public class Order {
    @TableId(value = "order_id", type = IdType.AUTO)
    private Integer orderId;
    private Integer userId;
    private Timestamp orderTime;
    private Timestamp payTime;
    private Integer status;
}
