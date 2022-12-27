package com.ticket.backend.service.user;

import java.util.Map;

public interface UserRealViewerService {
    public Map<String, Object> getRealViewerByUserId(Integer userId);
}
