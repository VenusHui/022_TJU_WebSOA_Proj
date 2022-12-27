package com.ticket.ticketsystem.controller;

import com.ticket.ticketsystem.service.HistrionicsDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HistrionicsDetailController {
    @Autowired
    HistrionicsDetailService histrionicsDetailService;

    @GetMapping("/histrionics/{histrionicsId}/ticket_stall")
    public ResponseEntity<Object> getTicketStallByHistrionics(@PathVariable Integer histrionicsId){
        return ResponseEntity.ok(histrionicsDetailService.getTicketStallByHistrionics(histrionicsId));
    }
}
