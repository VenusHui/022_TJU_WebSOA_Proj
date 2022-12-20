package com.ticket.ticketsystem.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class TicketStall {
    @TableId(value = "ticket_stall_id", type = IdType.AUTO)
    private Integer ticketStallId;
    private Integer histrionicsId;
    private String description;
    private Double price;
    private Integer capacity;
    private Integer remaining;
    private Integer sold;
    private String seatPosition;
}
