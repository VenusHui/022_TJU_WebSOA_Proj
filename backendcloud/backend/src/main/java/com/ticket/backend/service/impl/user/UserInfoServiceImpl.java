package com.ticket.backend.service.impl.user;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.ticket.backend.controller.UserController;
import com.ticket.backend.mapper.UserMapper;
import com.ticket.backend.pojo.User;
import com.ticket.backend.service.impl.utils.assembler.UserModelAssembler;
import com.ticket.backend.service.user.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.methodOn;

/**
 * @author: VenusHui
 * @description: TODO
 * @date: 2022/12/20 0:21
 * @version: 1.0
 */
@Service
public class UserInfoServiceImpl implements UserInfoService {

    @Autowired
    UserMapper userMapper;

    private final UserModelAssembler assembler;

    public UserInfoServiceImpl(UserModelAssembler assembler) {
        this.assembler = assembler;
    }

    @Override
    public Map<String, Object> getUser(Integer userId) {
        Map<String, Object> response = new HashMap<>();
        User user = userMapper.selectById(userId);
        if (user == null) {
            response.put("status", "error");
            response.put("message", "用户不存在");
            return response;
        }

        response.put("status", "success");
        response.put("message", "");
        response.put("data", assembler.toModel(user));
        return response;
    }

    @Override
    public Map<String, Object> getAll() {
        Map<String, Object> response = new HashMap<>();
        List<EntityModel<User>> users = userMapper.selectList(null).stream()
                .map(assembler::toModel)
                .collect(Collectors.toList());

        response.put("status", "success");
        response.put("message", "");
        response.put("data", CollectionModel.of(users,
                linkTo(methodOn(UserController.class).getAll()).withSelfRel()));
        return response;
    }

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

    @Override
    public Map<String, Object> putUserName(Integer userId, String newName){
        Map<String, Object> response = new HashMap<>();

        UpdateWrapper<User> userUpdateWrapper = new UpdateWrapper<>();
        userUpdateWrapper.set("user_name", newName).eq("user_id",userId);
        userMapper.update(null, userUpdateWrapper);

        response.put("status", "success");
        response.put("message", "用户修改用户名成功");
        response.put("data", null);

        return response;
    }
}
