package com.ticket.ticketsystem.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
/**
 * @author: VenusHui
 * @description: TODO
 * @date: 2022/12/20 14:57
 * @version: 1.0
 */
public class Purchase {
    @TableId(type = IdType.INPUT)
    private Integer orderId;
    private Integer ticketId;
}
