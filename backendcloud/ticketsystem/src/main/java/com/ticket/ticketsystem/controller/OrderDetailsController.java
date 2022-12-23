package com.ticket.ticketsystem.controller;

import com.ticket.ticketsystem.service.OrderDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class OrderDetailsController {

    @Autowired
    OrderDetailsService orderDetailsService;

    @GetMapping("/users/{userId}/orders/{orderId}")
    public ResponseEntity<Object> getOrderDetailsByOrderId(@PathVariable Integer orderId){
        return ResponseEntity.ok(orderDetailsService.getOrderDetailsByOrderId(orderId));
    }
}
