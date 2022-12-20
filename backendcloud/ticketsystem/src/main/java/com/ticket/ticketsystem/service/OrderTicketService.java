package com.ticket.ticketsystem.service;

import java.util.Map;

public interface OrderTicketService {
    public Map<String,Object> getTicketByOrderId(Integer orderId);
}
