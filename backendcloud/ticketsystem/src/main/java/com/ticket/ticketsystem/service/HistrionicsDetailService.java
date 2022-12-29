package com.ticket.ticketsystem.service;

import java.util.Map;

public interface HistrionicsDetailService {
    public Map<String,Object> getTicketStallByHistrionics(Integer histrionicsId);

    public Map<String,Object> getShowByHistrionics(Integer histrionicsId);
}
