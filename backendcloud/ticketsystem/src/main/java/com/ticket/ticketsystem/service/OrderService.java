package com.ticket.ticketsystem.service;

import java.util.Map;

public interface OrderService {
    public Map<String, Object> getOrderByUserId(Integer userId);
}
