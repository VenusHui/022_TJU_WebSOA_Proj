package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.HistrionicsMapper;
import com.ticket.ticketsystem.mapper.TicketStallMapper;
import com.ticket.ticketsystem.pojo.Histrionics;
import com.ticket.ticketsystem.pojo.TicketStall;
import com.ticket.ticketsystem.service.HistrionicsDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class HistrionicsDetailServiceImpl implements HistrionicsDetailService {

    @Autowired
    HistrionicsMapper histrionicsMapper;

    @Autowired
    TicketStallMapper ticketStallMapper;

    @Override
    public Map<String, Object> getTicketStallByHistrionics(Integer histrionicsId) {
        Map<String,Object> response=new HashMap<>();
        Map<String,Object> data=new HashMap<>();
        // query for ticketStall
        QueryWrapper<TicketStall> ticketStallQueryWrapper=new QueryWrapper<>();
        ticketStallQueryWrapper.eq("histrionics_id",histrionicsId);
        List<TicketStall> ticketStallList=ticketStallMapper.selectList(ticketStallQueryWrapper);
        // query for histrionics
        QueryWrapper<Histrionics> histrionicsQueryWrapper=new QueryWrapper<>();
        histrionicsQueryWrapper.eq("histrionics_id",histrionicsId);
        Histrionics histrionics=histrionicsMapper.selectOne(histrionicsQueryWrapper);
        // package for data
        data.put("ticket_stall",ticketStallList);
        data.put("histrionics",histrionics);

        response.put("status","success");
        response.put("message",data.size());
        response.put("data",data);
        return response;
    }
}
