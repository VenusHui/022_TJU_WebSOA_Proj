package com.ticket.sharingsystem.service;

import java.util.Map;

public interface SharingUserService {
    public Map<String,Object> getUserCommentBySharingId(Integer sharingId);
}
