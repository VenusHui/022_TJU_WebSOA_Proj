package com.ticket.backend.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private Integer id;
    private String user_name;
    private String password;
    private Integer user_type;
    private String phone_number;
    private Date register_date;
    private String city;
    private Integer credit;
}
