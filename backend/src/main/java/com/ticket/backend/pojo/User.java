package com.ticket.backend.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    @TableId(value = "user_id", type = IdType.AUTO)
    private Integer user_id;
    private String user_name;
    private String password;
    private Integer user_type;
    private String phone_number;
    private Date register_date;
    private String city;
    private Integer credit;
}
