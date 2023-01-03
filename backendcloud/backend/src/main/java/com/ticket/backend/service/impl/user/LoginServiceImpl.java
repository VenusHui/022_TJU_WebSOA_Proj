package com.ticket.backend.service.impl.user;

import com.ticket.backend.pojo.User;
import com.ticket.backend.service.impl.utils.UserDetailsImpl;
import com.ticket.backend.service.impl.utils.assembler.UserModelAssembler;
import com.ticket.backend.service.user.LoginService;
import com.ticket.backend.utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    private AuthenticationManager authenticationManager;

    private final UserModelAssembler assembler;

    public LoginServiceImpl(UserModelAssembler assembler) {
        this.assembler = assembler;
    }

    @Override
    public Map<String, Object> getToken(String userName, String password) {
        Map<String, Object> response = new HashMap<>();
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(userName, password);
        Authentication authentication = authenticationManager.authenticate(authenticationToken);
        UserDetailsImpl loginUser = (UserDetailsImpl) authentication.getPrincipal();
        User user = loginUser.getUser();
        String jwt = JwtUtil.createJWT(user.getUserId().toString());

        Map<String, Object> data = new HashMap<>();
        data.put("userId", user.getUserId());
        data.put("token", jwt);

        response.put("status", "success");
        response.put("message", "登录成功");
        response.put("data", data);
        return response;
    }
}
