package com.ticket.ticketsystem.controller;

import com.ticket.ticketsystem.service.OrderTicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class OrderTicketController {

    @Autowired
    OrderTicketService orderTicketService;

    @GetMapping("/users/{userId}/orders/{orderId}/tickets/")
    public ResponseEntity<Object> getTicketsByOrderId(@PathVariable Integer orderId) {
        return ResponseEntity.ok(orderTicketService.getTicketByOrderId(orderId));
    }

}
