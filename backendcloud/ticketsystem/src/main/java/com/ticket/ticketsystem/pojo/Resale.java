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
public class Resale {
    @TableId(value="resale_id",type= IdType.AUTO)
    private Integer resaleId;
    private Integer sellerId;
    private Integer buyerId;
    private Double price;
    private Timestamp publishTime;
    private Integer ticketId;
    private Integer status;
}
