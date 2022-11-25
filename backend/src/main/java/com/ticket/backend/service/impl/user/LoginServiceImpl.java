package com.ticket.backend.service.impl.user;

import com.ticket.backend.pojo.User;
import com.ticket.backend.service.impl.utils.UserDetailsImpl;
import com.ticket.backend.service.user.LoginService;
import com.ticket.backend.utils.JwtUtil;
import com.ticket.backend.utils.model.BasicReturn;
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

    @Override
    public BasicReturn getToken(String userName, String password) {
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(userName, password);
        Authentication authenticate = authenticationManager.authenticate(authenticationToken);
        UserDetailsImpl loginUser = (UserDetailsImpl) authenticate.getPrincipal();
        User user = loginUser.getUser();
        String jwt = JwtUtil.createJWT(user.getUserId().toString());
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("token", jwt);
        return new BasicReturn(200, "success", data);
    }
}
