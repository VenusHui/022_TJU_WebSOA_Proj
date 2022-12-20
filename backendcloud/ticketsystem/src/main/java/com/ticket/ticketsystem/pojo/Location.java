package com.ticket.ticketsystem.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class Location {
    @TableId(value = "location_id", type = IdType.AUTO)
    private Integer locationId;
    private String name;
    private String locationType;
    private Double lat;
    private Double lng;
}
