package com.ticket.backend.utils.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BasicReturn {
    private Integer code;
    private String message;
    private Object data;
}
