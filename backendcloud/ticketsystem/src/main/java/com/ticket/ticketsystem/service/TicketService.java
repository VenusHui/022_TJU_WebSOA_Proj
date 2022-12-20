package com.ticket.ticketsystem.service;

import java.util.Map;

public interface TicketService {
    public Map<String,Object> getTicketByTicketId(Integer ticketId);
}
