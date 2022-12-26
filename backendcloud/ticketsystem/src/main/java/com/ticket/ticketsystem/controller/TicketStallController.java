package com.ticket.ticketsystem.controller;

import com.ticket.ticketsystem.service.TicketStallService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TicketStallController {
    @Autowired
    TicketStallService ticketStallService;

    @GetMapping("/users/{userId}/ticket_stall/{ticketStallId}")
    public ResponseEntity<Object> getTicketStall(@PathVariable Integer ticketStallId){
        return ResponseEntity.ok(ticketStallService.getTicketStall(ticketStallId));
    }

}
