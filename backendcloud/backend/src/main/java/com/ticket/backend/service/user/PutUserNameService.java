package com.ticket.backend.service.user;

import java.util.Map;

public interface PutUserNameService {
    public Map<String,Object> putUserName(Integer userId, String newName);
}
