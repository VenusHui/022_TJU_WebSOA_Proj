package com.ticket.sharingsystem.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Comment {
    private Integer user_id;
    private String context;
    private Integer likes;
    private Date comment_time;
}
