package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.HistrionicsMapper;
import com.ticket.ticketsystem.mapper.ShowsMapper;
import com.ticket.ticketsystem.pojo.Histrionics;
import com.ticket.ticketsystem.pojo.Shows;
import com.ticket.ticketsystem.pojo.Ticket;
import com.ticket.ticketsystem.service.ShowDetailService;
import com.ticket.ticketsystem.service.impl.utils.assembler.ShowsModelAssembler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ShowDetailServiceImpl implements ShowDetailService {
    @Autowired
    ShowsMapper showsMapper;
    @Autowired
    HistrionicsMapper histrionicsMapper;

    private ShowsModelAssembler showsModelAssembler;

    public ShowDetailServiceImpl(ShowsModelAssembler showsModelAssembler){
        this.showsModelAssembler = showsModelAssembler;
    }

    @Override
    public Map<String, Object> getShowDetailByShowId(Integer showId) {
        Map<String, Object> response = new HashMap<>();

        QueryWrapper<Shows> showsQueryWrapper = new QueryWrapper<>();
        showsQueryWrapper.eq("show_id", showId);
        Shows show = showsMapper.selectOne(showsQueryWrapper);

        QueryWrapper<Histrionics> histrionicsQueryWrapper = new QueryWrapper<>();
        histrionicsQueryWrapper.eq("show_id",show.getShowId());
        List<Histrionics> histrionicsList = histrionicsMapper.selectList(histrionicsQueryWrapper);

        Map<String, Object> data = new HashMap<>();
        data.put("show",showsModelAssembler.toModel(show));
        data.put("histrionics", histrionicsList);

        response.put("status", "success");
        response.put("message", data.size());
        response.put("data", data);
        return response;
    }
}
