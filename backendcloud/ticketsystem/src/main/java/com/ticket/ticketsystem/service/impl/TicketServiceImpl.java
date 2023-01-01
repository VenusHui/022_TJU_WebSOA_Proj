package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.*;
import com.ticket.ticketsystem.pojo.*;
import com.ticket.ticketsystem.service.TicketService;
import com.ticket.ticketsystem.service.impl.utils.assembler.TicketModelAssembler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TicketServiceImpl implements TicketService {

    @Autowired
    TicketMapper ticketMapper;
    @Autowired
    TicketStallMapper ticketStallMapper;
    @Autowired
    HistrionicsMapper histrionicsMapper;
    @Autowired
    ShowsMapper showsMapper;
    @Autowired
    OrdersMapper ordersMapper;
    @Autowired
    ResaleMapper resaleMapper;
    @Autowired
    PurchaseMapper purchaseMapper;

    private TicketModelAssembler ticketModelAssembler;

    public TicketServiceImpl(TicketModelAssembler ticketModelAssembler) {
        this.ticketModelAssembler = ticketModelAssembler;
    }

    @Override
    public Map<String, Object> getTicketDetail(Integer ticketId) {
        Map<String, Object> response = new HashMap<>();

        QueryWrapper<Ticket> ticketQueryWrapper = new QueryWrapper<>();
        ticketQueryWrapper.eq("ticket_id", ticketId);
        Ticket ticket = ticketMapper.selectOne(ticketQueryWrapper);

        QueryWrapper<TicketStall> ticketStallQueryWrapper = new QueryWrapper<>();
        ticketStallQueryWrapper.eq("ticket_stall_id", ticket.getTicketStallId());
        TicketStall ticketStall = ticketStallMapper.selectOne(ticketStallQueryWrapper);

        QueryWrapper<Histrionics> histrionicsQueryWrapper = new QueryWrapper<>();
        histrionicsQueryWrapper.eq("histrionics_id", ticketStall.getHistrionicsId());
        Histrionics histrionics = histrionicsMapper.selectOne(histrionicsQueryWrapper);

        QueryWrapper<Shows> showQueryWrapper = new QueryWrapper<>();
        showQueryWrapper.eq("show_id", histrionics.getShowId());
        Shows shows = showsMapper.selectOne(showQueryWrapper);

        Map<String, Object> data = new HashMap<>();
        data.put("ticket", ticketModelAssembler.toModel(ticket));
        data.put("ticket_stall", ticketStall);
        data.put("histrionics", histrionics);
        data.put("shows", shows);

        response.put("status", "success");
        response.put("message", data.size());
        response.put("data", data);

        return response;
    }

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
