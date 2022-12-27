package com.ticket.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.ticket.backend.mapper.UserMapper;
import com.ticket.backend.pojo.User;
import com.ticket.backend.service.user.PutUserCityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class PutUserCityServiceImpl implements PutUserCityService {
    @Autowired
    private UserMapper userMapper;

    @Override
    public Map<String, Object> putUserCity(Integer userId, String newCity){
        Map<String, Object> response = new HashMap<>();

        UpdateWrapper<User> userUpdateWrapper = new UpdateWrapper<>();
        userUpdateWrapper.set("city", newCity).eq("user_id",userId);
        userMapper.update(null, userUpdateWrapper);

        response.put("status", "success");
        response.put("message", "用户修改城市成功");
        response.put("data", null);

        return response;
    }
}
