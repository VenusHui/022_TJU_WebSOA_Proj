package com.ticket.backend.controller.user;

import com.ticket.backend.mapper.UserMapper;
import com.ticket.backend.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class UserController {

    @Autowired
    UserMapper userMapper;
    @RequestMapping("/users/")
    public List<User> getAll() {
        return userMapper.selectList(null);
    }
}
