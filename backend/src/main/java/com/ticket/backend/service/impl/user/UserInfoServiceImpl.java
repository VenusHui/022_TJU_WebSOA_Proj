package com.ticket.backend.service.impl.user;

import com.ticket.backend.pojo.User;
import com.ticket.backend.service.impl.utils.UserDetailsImpl;
import com.ticket.backend.service.user.UserInfoService;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class UserInfoServiceImpl implements UserInfoService {

    @Override
    public Map<String, String> getUserInfo() {
        UsernamePasswordAuthenticationToken authentication = (UsernamePasswordAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl loginUser = (UserDetailsImpl) authentication.getPrincipal();
        User user = loginUser.getUser();
        Map<String, String> msg = new HashMap<>();
        msg.put("code", "200");
        msg.put("message", "success");
        msg.put("data", user.getUserName());
        return msg;
    }
}
