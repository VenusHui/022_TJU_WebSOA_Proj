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
    public ResponseEntity<Object> getTicketDetail(@PathVariable Integer ticketId){
        return ResponseEntity.ok(ticketService.getTicketDetail(ticketId));
    }

    @GetMapping("/users/{userId}/validTicket/")
    public ResponseEntity<Object> getValidTicketByUserId(@PathVariable Integer userId){
        return ResponseEntity.ok(ticketService.getValidTicketByUserId(userId));
    }
    @GetMapping("/users/{userId}/orders/{orderId}/tickets/")
    public ResponseEntity<Object> getTicketsByOrderId(@PathVariable Integer orderId) {
        return ResponseEntity.ok(ticketService.getTicketByOrderId(orderId));
    }
}
