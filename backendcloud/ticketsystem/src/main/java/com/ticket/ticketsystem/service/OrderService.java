package com.ticket.ticketsystem.service;

import java.util.List;
import java.util.Map;

public interface OrderService {
    public Map<String, Object> getOrderByUserId(Integer userId);
    public Map<String,Object> getOrderDetailByOrderId(Integer orderId);
    public Map<String,Object> postOrder(Integer userId,Integer ticketStallId, Integer num, List<String> viewers);
}
