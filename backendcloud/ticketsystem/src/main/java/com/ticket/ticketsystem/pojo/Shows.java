package com.ticket.ticketsystem.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class Shows {
    @TableId(value = "show_id", type = IdType.AUTO)
    private Integer showId;
    private String title;
    private String description;
    private String image;
    private String categories;
}
