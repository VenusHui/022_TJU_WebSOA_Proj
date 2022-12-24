package com.ticket.ticketsystem.service;

import java.util.Map;

public interface OrderDetailService {
    public Map<String,Object> getOrderDetailByOrderId(Integer orderId);
}
