package com.ticket.ticketsystem.controller;

import com.ticket.ticketsystem.service.OrderDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class OrderDetailController {
    @Autowired
    OrderDetailService orderDetailService;

    @GetMapping("/users/{userId}/orders/{orderId}")
    public ResponseEntity<Object> getOrderDetailByOrderId(@PathVariable Integer orderId){
        return ResponseEntity.ok(orderDetailService.getOrderDetailByOrderId(orderId));
    }
}
