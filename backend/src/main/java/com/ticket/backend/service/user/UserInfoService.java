package com.ticket.backend.service.user;

import java.util.Map;

public interface UserInfoService {
    public Map<String, Object> getUser(Integer userId);
    public Map<String, Object> getAll();
}
