package com.ticket.ticketsystem.controller;

import com.ticket.ticketsystem.service.TicketDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TicketDetailController {
    @Autowired
    TicketDetailService ticketDetailService;

    @GetMapping("/users/{userId}/tickets/{ticketId}/")
    public ResponseEntity<Object> getTicketDetail(@PathVariable Integer ticketId){
        return ResponseEntity.ok(ticketDetailService.getTicketDetail(ticketId));
    }
}
