package com.ticket.sharingsystem.service;

import java.util.Map;

public interface GetUserSharingService {
    public Map<String, Object> getUserSharingByUserId(Integer userId);
}
