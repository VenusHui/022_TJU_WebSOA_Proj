package com.ticket.ticketsystem.service;

import java.util.Map;

public interface ResaleService {
    public Map<String,Object> postResale(Integer userId, Integer ticketId,Double price);

    public Map<String,Object> getResaleByShow(Integer showId);
}
