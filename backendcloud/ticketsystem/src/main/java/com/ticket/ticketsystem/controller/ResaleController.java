package com.ticket.ticketsystem.controller;

import com.ticket.ticketsystem.service.ResaleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
public class ResaleController {
    @Autowired
    ResaleService resaleService;

    @PostMapping("/users/{userId}/tickets/{ticketId}/resale/")
    public ResponseEntity<Object> postResale(@PathVariable Integer userId, @PathVariable Integer ticketId, @RequestParam(value = "resale_price") String str_price){
        Double price=Double.parseDouble(str_price);
        return ResponseEntity.ok(resaleService.postResale(userId,ticketId,price));
    }

    @GetMapping("/shows/{showId}/resale/")
    public ResponseEntity<Object> getResaleByShow(@PathVariable Integer showId){
        return ResponseEntity.ok(resaleService.getResaleByShow(showId));
    }

    @GetMapping("/users/{userId}/resale/")
    public ResponseEntity<Object> getResaleByUser(@PathVariable Integer userId){
        return ResponseEntity.ok(resaleService.getResaleByUser(userId));

    }

    @PostMapping("/users/{userId}/resales/{resaleId}/")
    public ResponseEntity<Object> purchaseResale(@PathVariable Integer userId,@PathVariable Integer resaleId){
        return ResponseEntity.ok(resaleService.purchaseResale(userId,resaleId));
    }
}
