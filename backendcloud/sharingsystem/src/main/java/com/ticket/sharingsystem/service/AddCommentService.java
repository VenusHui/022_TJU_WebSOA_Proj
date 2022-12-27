package com.ticket.sharingsystem.service;

import java.util.Map;

public interface AddCommentService {
    public Map<String,Object> addComment(Integer sharingId, Integer userId, String context);
}
