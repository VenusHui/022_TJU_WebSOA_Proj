package com.ticket.ticketsystem.service;

import java.util.Map;

public interface OrderDetailsService {
    public Map<String, Object> getOrderDetailsByOrderId(Integer orderId);
}
