package com.ticket.ticketsystem.service;

import java.util.List;
import java.util.Map;

public interface PurchaseService {
    public Map<String,Object> postOrder(Integer userId,Integer ticketStallId, Integer num, List<String> viewers);
}
