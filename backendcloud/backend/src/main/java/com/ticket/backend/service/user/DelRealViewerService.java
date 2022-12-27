package com.ticket.backend.service.user;

import java.util.Map;

public interface DelRealViewerService {
    public Map<String,Object> delRealViewer(Integer userId, String identityNumber, String name);
}
