package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.*;
import com.ticket.ticketsystem.pojo.Orders;
import com.ticket.ticketsystem.pojo.Purchase;
import com.ticket.ticketsystem.pojo.Ticket;
import com.ticket.ticketsystem.pojo.TicketStall;
import com.ticket.ticketsystem.service.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PurchaseServiceImpl implements PurchaseService {

    @Autowired
    TicketStallMapper ticketStallMapper;

    @Autowired
    HistrionicsMapper histrionicsMapper;

    @Autowired
    TicketMapper ticketMapper;

    @Autowired
    OrdersMapper ordersMapper;

    @Autowired
    PurchaseMapper purchaseMapper;

    @Override
    public Map<String, Object> postOrder(Integer userId,Integer ticketStallId, Integer num, List<String> viewers) {
        Map<String,Object> response=new HashMap<>();
        if(num==null||viewers==null){
            response.put("status","error");
            response.put("message","参数不能为空");
            return response;
        }
        if(num<=0){
            response.put("status","error");
            response.put("message","购票数目必须为正整数");
            return response;
        }
        if(num!=viewers.size()){
            response.put("status","error");
            response.put("message","错误的参数个数");
            return response;
        }

        QueryWrapper<TicketStall> ticketStallQueryWrapper=new QueryWrapper<>();
        ticketStallQueryWrapper.eq("ticket_stall_id",ticketStallId);
        TicketStall ticketStall=ticketStallMapper.selectOne(ticketStallQueryWrapper);

        if(ticketStall.getRemaining()<num){
            response.put("status","error");
            response.put("message","剩余库存不足");
            return response;
        }

        int remaining=ticketStall.getRemaining();
        int sold=ticketStall.getSold();

        ticketStall.setRemaining(remaining-num);
        ticketStall.setSold(sold+num);

        ticketStallMapper.update(ticketStall,ticketStallQueryWrapper);

        double totalPrice=num*ticketStall.getPrice();
        Orders orders=new Orders(null,userId, new Timestamp(System.currentTimeMillis()),null,1,totalPrice,ticketStall.getHistrionicsId());
        ordersMapper.insert(orders);
        for(int i=0;i<num;i++){
            Ticket ticket=new Ticket(null,ticketStallId,viewers.get(i),null,1);
            ticketMapper.insert(ticket);
            Purchase purchase=new Purchase(orders.getOrderId(), ticket.getTicketId());
            purchaseMapper.insert(purchase);
        }

        response.put("status","success");
        response.put("message","订单创建成功");
        response.put("data",orders);

        return response;
    }
}
