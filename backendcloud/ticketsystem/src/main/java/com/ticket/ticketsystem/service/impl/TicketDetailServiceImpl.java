package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.HistrionicsMapper;
import com.ticket.ticketsystem.mapper.ShowsMapper;
import com.ticket.ticketsystem.mapper.TicketMapper;
import com.ticket.ticketsystem.mapper.TicketStallMapper;
import com.ticket.ticketsystem.pojo.Histrionics;
import com.ticket.ticketsystem.pojo.Shows;
import com.ticket.ticketsystem.pojo.Ticket;
import com.ticket.ticketsystem.pojo.TicketStall;
import com.ticket.ticketsystem.service.TicketDetailService;
import com.ticket.ticketsystem.service.impl.utils.assembler.TicketModelAssembler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class TicketDetailServiceImpl implements TicketDetailService {

    @Autowired
    TicketMapper ticketMapper;
    @Autowired
    TicketStallMapper ticketStallMapper;
    @Autowired
    HistrionicsMapper histrionicsMapper;
    @Autowired
    ShowsMapper showsMapper;

    private TicketModelAssembler ticketModelAssembler;

    public TicketDetailServiceImpl(TicketModelAssembler ticketModelAssembler) {
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
}
