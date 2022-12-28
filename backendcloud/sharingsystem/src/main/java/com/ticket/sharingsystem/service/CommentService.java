package com.ticket.sharingsystem.service;

import java.util.Map;

public interface CommentService {
    public Map<String, Object> getAll(String sharingId);

    public Map<String, Object> addComment(String sharingId, Integer userId, String context);

    public Map<String, Object> getCommentsByUserId(String sharingId, Integer userId);
}
