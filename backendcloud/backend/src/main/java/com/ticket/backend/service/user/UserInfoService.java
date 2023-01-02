package com.ticket.backend.service.user;

import java.util.Map;

public interface UserInfoService {
    public Map<String, Object> getUser(Integer userId);
    public Map<String, Object> getAll();
    public Map<String,Object> putUserCity(Integer userId, String newCity);
    public Map<String,Object> putUserName(Integer userId, String newName);
    public Map<String,Object> putUserAvatar(Integer userId,String newAvatar);
}
