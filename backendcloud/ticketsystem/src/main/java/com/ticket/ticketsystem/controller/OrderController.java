package com.ticket.ticketsystem.controller;

import com.ticket.ticketsystem.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * @author: VenusHui
 * @description: TODO
 * @date: 2022/12/20 15:13
 * @version: 1.0
 */
public class OrderController {

    @Autowired
    OrderService orderService;

    @GetMapping("/users/{userId}/orders/")
    public ResponseEntity<Object> getOrders(@PathVariable Integer userId) {
        return ResponseEntity.ok(orderService.getOrderByUserId(userId));
    }
}
