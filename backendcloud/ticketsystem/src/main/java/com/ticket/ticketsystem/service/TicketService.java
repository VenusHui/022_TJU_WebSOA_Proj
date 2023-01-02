package com.ticket.ticketsystem.service;

import java.util.Map;

public interface TicketService {
    public Map<String,Object> getTicketDetail(Integer ticketId);

    public Map<String,Object> getTicketByOrderId(Integer orderId);

    public Map<String,Object> getValidTicketByUserId(Integer userId);

    public Map<String,Object> verifyTicket(Integer ticketId);
}
