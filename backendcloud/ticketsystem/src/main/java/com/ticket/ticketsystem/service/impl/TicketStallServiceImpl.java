package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.TicketStallMapper;
import com.ticket.ticketsystem.pojo.TicketStall;
import com.ticket.ticketsystem.service.TicketStallService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class TicketStallServiceImpl implements TicketStallService {
    @Autowired
    TicketStallMapper ticketStallMapper;

    @Override
    public Map<String, Object> getTicketStall(Integer ticketStallId) {
        Map<String,Object> response=new HashMap<>();
        QueryWrapper<TicketStall> ticketStallQueryWrapper=new QueryWrapper<>();
        ticketStallQueryWrapper.eq("ticket_stall_id",ticketStallId);
        TicketStall ticketStall=ticketStallMapper.selectOne(ticketStallQueryWrapper);

        int remaining=ticketStall.getRemaining();
        response.put("status","success");
        if(remaining>0){
            response.put("message","Remaining");
        }
        else{
            response.put("message","Soldout");
        }
        response.put("data",ticketStall);
        return response;
    }
}
