package com.ticket.ticketsystem.service;
import java.util.Map;
public interface ShowsService {
    public Map<String,Object> getShowDetailByShowId(Integer showId);
    public Map<String,Object> getShowsByKeyword(String Keyword);
    public Map<String,Object> getShowDetailByCategories(String Categories);
    public Map<String,Object> getTicketStall(Integer ticketStallId);
    public Map<String,Object> getTicketStallByHistrionics(Integer histrionicsId);
    public Map<String,Object> getShowByHistrionics(Integer histrionicsId);
    public Map<String,Object> getAllHistrionics();
    public Map<String,Object> getShows1to5();
}
