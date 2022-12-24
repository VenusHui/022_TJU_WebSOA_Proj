package com.ticket.sharingsystem.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor


public class Comment {
    @TableId(value = "comment_id", type = IdType.AUTO)
    private Integer commentId;
    private Integer sharingId;
    private Integer userId;
    private String context;
    private Integer likes;
}
