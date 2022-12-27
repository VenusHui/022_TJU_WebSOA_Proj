package com.ticket.backend.service.user;

import java.util.Map;

public interface AddRealViewerService {
    public Map<String,Object> addRealViewer(Integer userId, String identityNumber, String name);
}
