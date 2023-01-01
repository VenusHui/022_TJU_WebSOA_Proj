package com.ticket.ticketsystem.controller;

import com.ticket.ticketsystem.service.ShowsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ShowsController {
    @Autowired
    ShowsService showsService;

    @GetMapping("/shows/{showId}/")
    public ResponseEntity<Object> getShowDetailByShowId(@PathVariable Integer showId){
        return ResponseEntity.ok(showsService.getShowDetailByShowId(showId));
    }
    @GetMapping("/users/{userId}/ticket_stall/{ticketStallId}/")
    public ResponseEntity<Object> getTicketStall(@PathVariable Integer ticketStallId){
        return ResponseEntity.ok(showsService.getTicketStall(ticketStallId));
    }
    @GetMapping("/search/")
    public ResponseEntity<Object> getShowsByKeyword(String keyword){
        return ResponseEntity.ok(showsService.getShowsByKeyword(keyword));
    }
    @GetMapping("/shows/")
    public ResponseEntity<Object> getShowDetailByCategories(String categories){
        return ResponseEntity.ok(showsService.getShowDetailByCategories(categories));
    }
    @GetMapping("/histrionics/{histrionicsId}/ticket_stall/")
    public ResponseEntity<Object> getTicketStallByHistrionics(@PathVariable Integer histrionicsId){
        return ResponseEntity.ok(showsService.getTicketStallByHistrionics(histrionicsId));
    }

    @GetMapping("/histrionics/{histrionicsId}/show/")
    public ResponseEntity<Object> getShowByHistrionics(@PathVariable Integer histrionicsId){
        return ResponseEntity.ok(showsService.getShowByHistrionics(histrionicsId));
    }

}
