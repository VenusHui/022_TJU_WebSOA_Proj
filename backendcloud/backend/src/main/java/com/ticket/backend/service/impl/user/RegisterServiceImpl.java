package com.ticket.backend.service.impl.user;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.backend.mapper.UserMapper;
import com.ticket.backend.pojo.User;
import com.ticket.backend.service.impl.utils.assembler.UserModelAssembler;
import com.ticket.backend.service.user.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RegisterServiceImpl implements RegisterService {
    @Autowired
    private UserMapper userMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    private final UserModelAssembler assembler;

    public RegisterServiceImpl(UserModelAssembler assembler) {
        this.assembler = assembler;
    }

    @Override
    public Map<String, Object> register(String userName, String password, String phoneNumber) {
        Map<String, Object> response = new HashMap<>();
        if (userName == null) {
            response.put("status", "error");
            response.put("message", "用户名为空");
            return response;
        }
        if (password == null) {
            response.put("status", "error");
            response.put("message", "密码为空");
            return response;
        }

        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_name", userName);
        List<User> users = userMapper.selectList(queryWrapper);
        if (!users.isEmpty()) {
            response.put("status", "error");
            response.put("message", "用户名已被使用");
        }

        String encodedPassword = passwordEncoder.encode(password);
        Timestamp timestamp = new Timestamp(new Date().getTime());
        User user = new User(null, userName, encodedPassword, phoneNumber, timestamp, null, null,50);
        userMapper.insert(user);
        Map<String, Object> data = new HashMap<>();
        data.put("user_id", user.getUserId());
        data.put("user_name", userName);

        response.put("status", "success");
        response.put("message", "注册成功");
        response.put("data", assembler.toModel(user));
        return response;
    }
}
