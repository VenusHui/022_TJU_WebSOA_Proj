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
 * @date: 2022/12/20 14:47
 * @version: 1.0
 */
public class Ticket {
    @TableId(value = "ticket_id", type = IdType.AUTO)
    private Integer ticketId;
    private Integer ticketStallId;
    private String identityNumber;
    private String seat;
    private Integer status;
}
