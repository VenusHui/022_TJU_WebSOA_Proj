package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.ResaleMapper;
import com.ticket.ticketsystem.mapper.TicketMapper;
import com.ticket.ticketsystem.pojo.Resale;
import com.ticket.ticketsystem.pojo.Ticket;
import com.ticket.ticketsystem.service.ResaleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

@Service
public class ResaleServiceImpl implements ResaleService {

    @Autowired
    ResaleMapper resaleMapper;
    @Autowired
    TicketMapper ticketMapper;

    @Override
    public Map<String, Object> postResale(Integer userId, Integer ticketId, Double price) {
        Map<String,Object> response=new HashMap<>();
        QueryWrapper<Ticket> ticketQueryWrapper=new QueryWrapper<>();
        ticketQueryWrapper.eq("ticket_id",ticketId);
        Ticket ticket=ticketMapper.selectOne(ticketQueryWrapper);
        int n_status=ticket.getStatus();
        if(n_status!=1){
            response.put("status","error");
            response.put("message","错误的票务状态");
            return response;
        }
        // Update ticket status
        ticket.setStatus(2);
        ticketMapper.update(ticket,ticketQueryWrapper);
        // create resale
        Resale resale=new Resale(null,userId,null,price,new Timestamp(System.currentTimeMillis()),ticketId,1);
        resaleMapper.insert(resale);
        // set response
        response.put("status","success");
        response.put("message","发布转卖成功");

        return response;
    }
}
