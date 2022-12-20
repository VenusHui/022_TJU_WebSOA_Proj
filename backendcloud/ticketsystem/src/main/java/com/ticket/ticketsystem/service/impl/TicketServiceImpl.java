package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.controller.mapper.TicketMapper;
import com.ticket.ticketsystem.pojo.Ticket;
import com.ticket.ticketsystem.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class TicketServiceImpl implements TicketService {

    @Autowired
    TicketMapper ticketMapper;

    @Override
    public Map<String,Object> getTicketByTicketId(Integer ticketId){
        Map<String, Object> respoense=new HashMap<>();
        QueryWrapper<Ticket> queryWrapper=new QueryWrapper<>();
        queryWrapper.eq("ticket_id",ticketId);
        Ticket ticket=ticketMapper.selectOne(queryWrapper);
        respoense.put("status","success");
        respoense.put("message","");
        respoense.put("data",ticket);
        return respoense;
    }
}
