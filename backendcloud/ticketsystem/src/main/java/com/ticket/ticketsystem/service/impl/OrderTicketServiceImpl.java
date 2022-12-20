package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.PurchaseMapper;
import com.ticket.ticketsystem.mapper.TicketMapper;
import com.ticket.ticketsystem.pojo.Purchase;
import com.ticket.ticketsystem.pojo.Ticket;
import com.ticket.ticketsystem.service.OrderTicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class OrderTicketServiceImpl implements OrderTicketService {
    @Autowired
    PurchaseMapper purchaseMapper;
    @Autowired
    TicketMapper ticketMapper;

    @Override
    public Map<String, Object> getTicketByOrderId(Integer orderId) {
        Map<String, Object> response = new HashMap<>();
        QueryWrapper<Purchase> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("order_id", orderId);
        List<Purchase> purchases = purchaseMapper.selectList(queryWrapper);
        System.out.println(purchases);
        List<Ticket> tickets = new ArrayList<>();
        for (int i = 0; i < purchases.size(); i++) {
            int ticketId = purchases.get(i).getTicketId();
            QueryWrapper<Ticket> ticketQueryWrapper = new QueryWrapper<>();
            ticketQueryWrapper.eq("ticket_id", ticketId);
            tickets.add(ticketMapper.selectOne((ticketQueryWrapper)));
        }
        response.put("status", "success");
        response.put("message", tickets.size());
        response.put("data", tickets);
        return response;
    }

}
