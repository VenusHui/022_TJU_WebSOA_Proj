package com.ticket.sharingsystem.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Sharing {
    @TableId(value = "sharing_id", type = IdType.AUTO)
    private Integer sharingId;
    private Integer userId;
    private Integer histrionicsId;
    private String context;
    private String imageUrl;
    private Integer stars;
    private Integer likes;
}
