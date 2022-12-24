package com.ticket.ticketsystem.controller;

import com.ticket.ticketsystem.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TicketController {
    @Autowired
    TicketService ticketService;

    @GetMapping("/users/{userId}/tickets/{ticketId}/")
    public ResponseEntity<Object> getTicketsByticketId(@PathVariable Integer ticketId){
        return ResponseEntity.ok(ticketService.getTicketByTicketId((ticketId)));
    }
}
