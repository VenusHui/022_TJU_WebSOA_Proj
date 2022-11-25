package com.ticket.backend.service.user;

import com.ticket.backend.utils.model.BasicReturn;

import java.util.Map;

public interface LoginService {
    public BasicReturn getToken(String userName, String password);
}
