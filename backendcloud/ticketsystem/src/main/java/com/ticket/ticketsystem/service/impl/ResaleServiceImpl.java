package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.HistrionicsMapper;
import com.ticket.ticketsystem.mapper.ResaleMapper;
import com.ticket.ticketsystem.mapper.TicketMapper;
import com.ticket.ticketsystem.mapper.TicketStallMapper;
import com.ticket.ticketsystem.pojo.Histrionics;
import com.ticket.ticketsystem.pojo.Resale;
import com.ticket.ticketsystem.pojo.Ticket;
import com.ticket.ticketsystem.pojo.TicketStall;
import com.ticket.ticketsystem.service.ResaleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.print.attribute.standard.JobKOctets;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ResaleServiceImpl implements ResaleService {

    @Autowired
    ResaleMapper resaleMapper;
    @Autowired
    TicketMapper ticketMapper;

    @Autowired
    HistrionicsMapper histrionicsMapper;

    @Autowired
    TicketStallMapper ticketStallMapper;

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

    @Override
    public Map<String, Object> getResaleByShow(Integer showId) {
        Map<String,Object> response=new HashMap<>();
        // query for histrionics
        QueryWrapper<Histrionics> histrionicsQueryWrapper=new QueryWrapper<>();
        histrionicsQueryWrapper.eq("show_id",showId);
        List<Histrionics> histrionicsList=histrionicsMapper.selectList(histrionicsQueryWrapper);

        List<Resale> resaleList=new ArrayList<>();
        // query for ticketStall
        for(int i=0;i<histrionicsList.size();i++){
            QueryWrapper<TicketStall> ticketStallQueryWrapper=new QueryWrapper<>();
            ticketStallQueryWrapper.eq("histrionics_id",histrionicsList.get(i).getHistrionicsId());
            List<TicketStall> ticketStallList=ticketStallMapper.selectList(ticketStallQueryWrapper);
            for(int j=0;j<ticketStallList.size();j++){
                QueryWrapper<Ticket> ticketQueryWrapper=new QueryWrapper<>();
                ticketQueryWrapper.eq("ticket_stall_id",ticketStallList.get(j).getTicketStallId());
                ticketQueryWrapper.eq("status",2);
                List<Ticket> ticketList=ticketMapper.selectList(ticketQueryWrapper);
                for(int k=0;k<ticketList.size();k++){
                    QueryWrapper<Resale> resaleQueryWrapper=new QueryWrapper<>();
                    resaleQueryWrapper.eq("ticket_id",ticketList.get(k).getTicketId());
                    resaleList.add(resaleMapper.selectOne(resaleQueryWrapper));
                }
            }
        }

        response.put("status","success");
        response.put("message",resaleList.size());
        response.put("data",resaleList);

        return response;
    }

    @Override
    public Map<String, Object> getResaleByUser(Integer userId) {
        Map<String, Object> response=new HashMap<>();
        QueryWrapper<Resale> resaleQueryWrapper=new QueryWrapper<>();
        resaleQueryWrapper.eq("seller_id",userId);
        List<Resale> resaleList=resaleMapper.selectList(resaleQueryWrapper);
        response.put("status","success");
        response.put("message",resaleList.size());
        response.put("data",resaleList);
        return response;
    }

    @Override
    public Map<String, Object> purchaseResale(Integer userId, Integer resaleId) {
        Map<String,Object> response=new HashMap<>();

        QueryWrapper<Resale> resaleQueryWrapper=new QueryWrapper<>();
        resaleQueryWrapper.eq("resale_id",resaleId);

        Resale resale=resaleMapper.selectOne(resaleQueryWrapper);
        int n_status=resale.getStatus();
        int ticketId=resale.getTicketId();
        if(n_status!=1){
            response.put("status","error");
            response.put("message","错误的转卖状态");
            return response;
        }
        resale.setBuyerId(userId);
        resale.setStatus(2);
        resaleMapper.update(resale,resaleQueryWrapper);

        QueryWrapper<Ticket> ticketQueryWrapper=new QueryWrapper<>();
        ticketQueryWrapper.eq("ticket_id",ticketId);
        Ticket ticket=ticketMapper.selectOne(ticketQueryWrapper);
        n_status=ticket.getStatus();
        if(n_status!=2){
            response.put("status","error");
            response.put("message","错误的票卷状态");
            return response;
        }
        ticket.setStatus(3);
        ticketMapper.update(ticket,ticketQueryWrapper);

        response.put("status","success");
        response.put("message","成功购买转卖票卷");
        return response;
    }
}
