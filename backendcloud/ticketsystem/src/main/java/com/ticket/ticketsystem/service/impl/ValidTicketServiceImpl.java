package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.OrdersMapper;
import com.ticket.ticketsystem.mapper.PurchaseMapper;
import com.ticket.ticketsystem.mapper.ResaleMapper;
import com.ticket.ticketsystem.mapper.TicketMapper;
import com.ticket.ticketsystem.pojo.Orders;
import com.ticket.ticketsystem.pojo.Purchase;
import com.ticket.ticketsystem.pojo.Resale;
import com.ticket.ticketsystem.pojo.Ticket;
import com.ticket.ticketsystem.service.ValidTicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ValidTicketServiceImpl implements ValidTicketService {

    @Autowired
    OrdersMapper ordersMapper;
    @Autowired
    PurchaseMapper purchaseMapper;
    @Autowired
    TicketMapper ticketMapper;

    @Autowired
    ResaleMapper resaleMapper;

    @Override
    public Map<String, Object> getValidTicketByUserId(Integer userId) {
        Map<String,Object> response=new HashMap<>();
        QueryWrapper<Orders> ordersQueryWrapper=new QueryWrapper<>();
        ordersQueryWrapper.eq("user_id",userId);
        List<Orders> ordersList=ordersMapper.selectList(ordersQueryWrapper);
        List<Ticket> valid_tickets=new ArrayList<>();
        for(int i=0;i<ordersList.size();i++){
            QueryWrapper<Purchase> purchaseQueryWrapper=new QueryWrapper<>();
            purchaseQueryWrapper.eq("order_id",ordersList.get(i).getOrderId());
            List<Purchase> purchaseList=purchaseMapper.selectList(purchaseQueryWrapper);
            for(int j=0;j<purchaseList.size();j++){
                int ticketId=purchaseList.get(j).getTicketId();
                QueryWrapper<Ticket> ticketQueryWrapper=new QueryWrapper<>();
                ticketQueryWrapper.eq("ticket_id",ticketId);
                ticketQueryWrapper.eq("status",1);
                Ticket ticket=ticketMapper.selectOne(ticketQueryWrapper);
                if(ticket!=null) {
                    valid_tickets.add(ticket);
                }
            }
        }

        QueryWrapper<Resale> resaleQueryWrapper=new QueryWrapper<>();
        resaleQueryWrapper.eq("buyer_id",userId);
        List<Resale> resaleList=resaleMapper.selectList(resaleQueryWrapper);
        for(int i=0;i<resaleList.size();i++){
            int ticketId=resaleList.get(i).getTicketId();
            QueryWrapper<Ticket> ticketQueryWrapper=new QueryWrapper<>();
            ticketQueryWrapper.eq("ticket_id",ticketId);
            ticketQueryWrapper.eq("status",3);
            Ticket ticket=ticketMapper.selectOne(ticketQueryWrapper);
            if(ticket!=null){
                valid_tickets.add(ticket);
            }
        }


        response.put("status","success");
        response.put("message",valid_tickets.size());
        response.put("data",valid_tickets);
        return response;
    }
}
