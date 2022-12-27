package com.ticket.ticketsystem.controller;

import com.ticket.ticketsystem.service.ResaleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ResaleController {
    @Autowired
    ResaleService resaleService;

    @PostMapping("/users/{userId}/tickets/{ticketId}/resale")
    public ResponseEntity<Object> postResale(@PathVariable Integer userId, @PathVariable Integer ticketId, @RequestParam(value = "resale_price") String str_price){
        Double price=Double.parseDouble(str_price);
        return ResponseEntity.ok(resaleService.postResale(userId,ticketId,price));
    }
}
