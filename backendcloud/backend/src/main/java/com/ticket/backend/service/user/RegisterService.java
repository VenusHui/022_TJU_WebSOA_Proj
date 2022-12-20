package com.ticket.backend.service.user;

import com.ticket.backend.pojo.User;

import java.util.Map;

public interface RegisterService {
    public Map<String, Object> register(String userName, String password, String phoneNumber);
}
