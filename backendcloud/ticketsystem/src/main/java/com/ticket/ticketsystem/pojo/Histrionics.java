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

public class Histrionics {
    @TableId(value = "histrionics_id", type = IdType.AUTO)
    private Integer histrionicsId;
    private Integer showId;
    private String description;
    private String detailUrl;
    private Timestamp startTime;
    private Integer duration;
    private Integer locationId;
    private Integer seatsId;
}
