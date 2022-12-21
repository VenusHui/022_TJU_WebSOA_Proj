package com.ticket.ticketsystem.service;

import java.util.Map;

public interface ValidTicketService {
    public Map<String,Object> getValidTicketByUserId(Integer userId);
}
