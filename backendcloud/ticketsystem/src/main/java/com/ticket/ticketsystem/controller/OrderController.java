package com.ticket.ticketsystem.controller;

import com.mysql.cj.xdevapi.JsonParser;
import com.ticket.ticketsystem.service.OrderService;
import com.ticket.ticketsystem.service.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


import java.util.List;
import java.util.Map;

import static java.lang.Integer.parseInt;


/**
 * @author: VenusHui
 * @description: TODO
 * @date: 2022/12/20 15:13
 * @version: 1.0
 */
@RestController
public class OrderController {

    @Autowired
    OrderService orderService;

    @Autowired
    PurchaseService purchaseService;

    @GetMapping("/users/{userId}/orders/")
    public ResponseEntity<Object> getOrders(@PathVariable Integer userId) {
        return ResponseEntity.ok(orderService.getOrderByUserId(userId));
    }

    @PostMapping("/users/{userId}/orders/")
    public ResponseEntity<Object> purchase(@PathVariable Integer userId,@RequestBody Map<String,Object> form){
        int ticketStallId=parseInt(form.get("ticket_stall_id").toString());
        int ticketNum=parseInt(form.get("ticket_num").toString());
        // System.out.println("Debug"+form.get("viewers_id").toString());
        List<String> viewers= (List<String>)form.get("viewers_id");
        return ResponseEntity.ok(purchaseService.postOrder(userId,ticketStallId,ticketNum,viewers));
    }
}
