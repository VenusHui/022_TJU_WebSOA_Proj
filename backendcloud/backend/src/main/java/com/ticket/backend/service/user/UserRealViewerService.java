package com.ticket.backend.service.user;

import java.util.Map;

public interface UserRealViewerService {
    public Map<String, Object> getRealViewerByUserId(Integer userId);

    public Map<String,Object> delRealViewer(Integer userId, String identityNumber, String name);

    public Map<String,Object> addRealViewer(Integer userId, String identityNumber, String name);
}
