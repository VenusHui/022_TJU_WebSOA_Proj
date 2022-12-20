package com.ticket.ticketsystem.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class Seats {
    @TableId(value = "seats_id", type = IdType.AUTO)
    private Integer seatsId;
    private Integer locationId;
    private String seat_map;
}
