package com.ticket.backend.controller.user;

import com.ticket.backend.service.user.LoginService;
import com.ticket.backend.utils.model.BasicReturn;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class LoginController {
    @Autowired
    private LoginService loginService;

    @PostMapping("/users/login/")
    public BasicReturn getToken(@RequestParam Map<String, String> map) {
        String userName = map.get("userName");
        String password = map.get("password");
        return loginService.getToken(userName, password);
    }
}
