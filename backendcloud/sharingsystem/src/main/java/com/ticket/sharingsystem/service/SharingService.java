package com.ticket.sharingsystem.service;

import java.util.Map;

public interface SharingService {
    public Map<String, Object> getAll();

    public Map<String, Object> getSharing(String sharingId);

    public Map<String, Object> addSharing(Integer userId, Integer histrionicsId, String context, String imageUrl);

    public Map<String, Object> setSharing(String sharingId, String context, String imageUrl, Integer stars, Integer likes);

    public Map<String, Object> getSharingsByUserId(Integer userId);

    public Map<String, Object> getSharingsByHistrionicsId(Integer histrionicsId);
}
