package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.controller.mapper.OrdersMapper;
import com.ticket.ticketsystem.controller.mapper.PurchaseMapper;
import com.ticket.ticketsystem.controller.mapper.TicketMapper;
import com.ticket.ticketsystem.pojo.Orders;
import com.ticket.ticketsystem.pojo.Purchase;
import com.ticket.ticketsystem.pojo.Ticket;
import com.ticket.ticketsystem.service.ValidTicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class validTicketServiceImpl implements ValidTicketService {

    @Autowired
    OrdersMapper ordersMapper;
    @Autowired
    PurchaseMapper purchaseMapper;
    @Autowired
    TicketMapper ticketMapper;

    @Override
    public Map<String, Object> getValidTicketByUserId(Integer userId) {
        Map<String,Object> respoense=new HashMap<>();
        QueryWrapper<Orders> ordersQueryWrapper=new QueryWrapper<>();
        ordersQueryWrapper.eq("user_id",userId);
        List<Orders> ordersList=ordersMapper.selectList(ordersQueryWrapper);
        List<Ticket> validtickets=new ArrayList<>();
        for(int i=0;i<ordersList.size();i++){
            QueryWrapper<Purchase> purchaseQueryWrapper=new QueryWrapper<>();
            purchaseQueryWrapper.eq("order_id",ordersList.get(i).getOrderId());
            List<Purchase> purchaseList=purchaseMapper.selectList(purchaseQueryWrapper);
            for(int j=0;j<purchaseList.size();j++){
                int ticketId=purchaseList.get(j).getTicketId();
                QueryWrapper<Ticket> ticketQueryWrapper=new QueryWrapper<>();
                ticketQueryWrapper.eq("ticket_id",ticketId);
                ticketQueryWrapper.eq("status",1);
                validtickets.add(ticketMapper.selectOne(ticketQueryWrapper));
            }
        }
        respoense.put("status","success");
        respoense.put("message",validtickets.size());
        respoense.put("data",validtickets);
        return respoense;
    }
}
