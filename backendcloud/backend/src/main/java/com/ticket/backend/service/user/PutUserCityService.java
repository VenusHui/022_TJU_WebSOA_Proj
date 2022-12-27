package com.ticket.backend.service.user;

import java.util.Map;

public interface PutUserCityService {
    public Map<String,Object> putUserCity(Integer userId, String newCity);
}
