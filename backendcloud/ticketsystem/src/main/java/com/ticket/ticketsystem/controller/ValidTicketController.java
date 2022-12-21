package com.ticket.ticketsystem.controller;

import com.ticket.ticketsystem.service.ValidTicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ValidTicketController {
    @Autowired
    ValidTicketService validTicketService;

    @GetMapping("/users/{userId}/validTicket/")
    public ResponseEntity<Object> getValidTicketByUserId(@PathVariable Integer userId){
        return ResponseEntity.ok(validTicketService.getValidTicketByUserId(userId));
    }
}
