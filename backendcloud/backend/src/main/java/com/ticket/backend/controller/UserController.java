package com.ticket.backend.controller;

import com.ticket.backend.mapper.UserMapper;
import com.ticket.backend.service.user.LoginService;
import com.ticket.backend.service.user.RegisterService;
import com.ticket.backend.service.user.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RefreshScope
public class UserController {

    @Autowired
    UserMapper userMapper;

    @Autowired
    LoginService loginService;

    @Autowired
    RegisterService registerService;

    @Autowired
    UserInfoService userInfoService;


    @GetMapping("/users/")
    public ResponseEntity<Object> getAll() {
        return ResponseEntity.ok(userInfoService.getAll());
    }

    @PostMapping("/users/")
    /**
     * @param form:
     * @return: ResponseEntity<Map<String,Object>>
     * @author: VenusHui
     * @description: 用户注册
     * @date: 2022/12/19 23:03
     */
    public ResponseEntity<Object> register(@RequestParam Map<String, Object> form) {
        String userName = form.get("user_name").toString();
        String password = form.get("password").toString();
        String phoneNumber = form.get("phone_number").toString();
        return ResponseEntity.ok(registerService.register(userName, password, phoneNumber));
    }

    @GetMapping("/users/{userId}/")
    /**
     * @param userId:
     * @return: ResponseEntity<Object>
     * @author: VenusHui
     * @description: 查询指定用户信息
     * @date: 2022/12/20 0:35
     */
    public ResponseEntity<Object> getUser(@PathVariable Integer userId) {
        return ResponseEntity.ok(userInfoService.getUser(userId));
    }

    @PostMapping("/users/token/")
    /**
     * @param form:
     * @return: ResponseEntity<Map<String,Object>>
     * @author: VenusHui
     * @description: 用户登录
     * @date: 2022/12/19 23:05
     */
    public ResponseEntity<Map<String, Object>> getToken(@RequestParam Map<String, Object> form) {
        String userName = form.get("user_name").toString();
        String password = form.get("password").toString();
        return ResponseEntity.ok(loginService.getToken(userName, password));
    }

    @PutMapping("/users/{userId}/city/")
    public ResponseEntity<Object> putUserCity(@PathVariable Integer userId, @RequestParam Map<String, Object> form){
        String newCity = form.get("new_city").toString();
        return ResponseEntity.ok(userInfoService.putUserCity(userId, newCity));
    }

    @PutMapping("/users/{userId}/name/")
    public ResponseEntity<Object> putUserName(@PathVariable Integer userId, @RequestParam Map<String, Object> form){
        String newName = form.get("new_name").toString();
        return ResponseEntity.ok(userInfoService.putUserName(userId, newName));
    }
}
