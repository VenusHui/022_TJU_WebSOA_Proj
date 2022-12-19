package com.ticket.backend.service.user;

import java.util.Map;

public interface LoginService {
    public Map<String, Object> getToken(String userName, String password);
}
