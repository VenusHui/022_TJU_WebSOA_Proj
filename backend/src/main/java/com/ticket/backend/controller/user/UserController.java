package com.ticket.backend.controller.user;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user/")
public class UserController {
    @RequestMapping("getUserInfo/")
    public String getUserInfo() {
        return "Hello World";
    }
}
