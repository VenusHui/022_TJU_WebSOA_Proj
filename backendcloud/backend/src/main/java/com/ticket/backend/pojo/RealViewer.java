package com.ticket.backend.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RealViewer {
    @TableId(value = "user_id", type = IdType.AUTO)
    private Integer userId;
    private String identityNumber;
    private String phoneNumber;
    private String name;
}
