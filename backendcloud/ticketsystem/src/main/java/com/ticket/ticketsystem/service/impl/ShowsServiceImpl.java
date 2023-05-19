package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.HistrionicsMapper;
import com.ticket.ticketsystem.mapper.ShowsMapper;
import com.ticket.ticketsystem.mapper.TicketStallMapper;
import com.ticket.ticketsystem.pojo.Histrionics;
import com.ticket.ticketsystem.pojo.Shows;
import com.ticket.ticketsystem.pojo.TicketStall;
import com.ticket.ticketsystem.service.ShowsService;
import com.ticket.ticketsystem.service.impl.utils.assembler.ShowsModelAssembler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ShowsServiceImpl implements ShowsService {

  private final ShowsMapper showsMapper;
  private final HistrionicsMapper histrionicsMapper;
  private final  TicketStallMapper ticketStallMapper;

//  @Autowired
//  ShowsMapper showsMapper;
//  @Autowired
//  HistrionicsMapper histrionicsMapper;
//  @Autowired
//  TicketStallMapper ticketStallMapper;
  private ShowsModelAssembler showsModelAssembler;

  @Autowired
  public ShowsServiceImpl(
      ShowsMapper showsMapper,
      HistrionicsMapper histrionicsMapper,
      TicketStallMapper ticketStallMapper,
      ShowsModelAssembler showsModelAssembler) {
    this.showsModelAssembler = showsModelAssembler;
    this.showsMapper=showsMapper;
    this.histrionicsMapper=histrionicsMapper;
    this.ticketStallMapper=ticketStallMapper;
  }

  @Override
  public Map<String, Object> getShowDetailByShowId(Integer showId) {
    Map<String, Object> response = new HashMap<>();

    QueryWrapper<Shows> showsQueryWrapper = new QueryWrapper<>();
    showsQueryWrapper.eq("show_id", showId);
    Shows show = showsMapper.selectOne(showsQueryWrapper);

    QueryWrapper<Histrionics> histrionicsQueryWrapper = new QueryWrapper<>();
    histrionicsQueryWrapper.eq("show_id", show.getShowId());
    List<Histrionics> histrionicsList = histrionicsMapper.selectList(histrionicsQueryWrapper);

    Map<String, Object> data = new HashMap<>();
    data.put("show", showsModelAssembler.toModel(show));
    data.put("histrionics", histrionicsList);

    response.put("status", "success");
    response.put("message", data.size());
    response.put("data", data);
    return response;
  }

  @Override
  public Map<String, Object> getTicketStall(Integer ticketStallId) {
    Map<String, Object> response = new HashMap<>();
    QueryWrapper<TicketStall> ticketStallQueryWrapper = new QueryWrapper<>();
    ticketStallQueryWrapper.eq("ticket_stall_id", ticketStallId);
    TicketStall ticketStall = ticketStallMapper.selectOne(ticketStallQueryWrapper);

    int remaining = ticketStall.getRemaining();
    response.put("status", "success");
    if (remaining > 0) {
      response.put("message", "Remaining");
    } else {
      response.put("message", "Soldout");
    }
    response.put("data", ticketStall);
    return response;
  }

  @Override
  public Map<String, Object> getShowsByKeyword(String keyword) {
    Map<String, Object> response = new HashMap<>();

    List<Shows> allShowsList = showsMapper.selectList(null);

    List<Shows> showsList = new ArrayList<>();

    // 进行字符串子串包含匹配
    for (int i = 0; i < allShowsList.size(); i++) {
      if (allShowsList.get(i).getTitle().contains(keyword)) {
        showsList.add(allShowsList.get(i));
      }
    }

    response.put("status", "success");
    response.put("message", showsList.size());
    response.put("data", showsModelAssembler.toCollectionModel(showsList));

    return response;
  }

  @Override
  public Map<String, Object> getShowDetailByCategories(String categories) {
    Map<String, Object> response = new HashMap<>();

    QueryWrapper<Shows> showsQueryWrapper = new QueryWrapper<>();
    showsQueryWrapper.eq("categories", categories);
    List<Shows> showsList = showsMapper.selectList(showsQueryWrapper);

    response.put("status", "success");
    response.put("message", showsList.size());
    response.put("data", showsModelAssembler.toCollectionModel(showsList));

    return response;
  }

  @Override
  public Map<String, Object> getTicketStallByHistrionics(Integer histrionicsId) {
    Map<String, Object> response = new HashMap<>();
    Map<String, Object> data = new HashMap<>();
    // query for ticketStall
    QueryWrapper<TicketStall> ticketStallQueryWrapper = new QueryWrapper<>();
    ticketStallQueryWrapper.eq("histrionics_id", histrionicsId);
    List<TicketStall> ticketStallList = ticketStallMapper.selectList(ticketStallQueryWrapper);
    // query for histrionics
    QueryWrapper<Histrionics> histrionicsQueryWrapper = new QueryWrapper<>();
    histrionicsQueryWrapper.eq("histrionics_id", histrionicsId);
    Histrionics histrionics = histrionicsMapper.selectOne(histrionicsQueryWrapper);
    // package for data
    data.put("ticket_stall", ticketStallList);
    data.put("histrionics", histrionics);

    response.put("status", "success");
    response.put("message", data.size());
    response.put("data", data);
    return response;
  }

  @Override
  public Map<String, Object> getShowByHistrionics(Integer histrionicsId) {
    Map<String, Object> response = new HashMap<>();
    Map<String, Object> data = new HashMap<>();
    // query for histrionics
    QueryWrapper<Histrionics> histrionicsQueryWrapper = new QueryWrapper<>();
    histrionicsQueryWrapper.eq("histrionics_id", histrionicsId);
    Histrionics histrionics = histrionicsMapper.selectOne(histrionicsQueryWrapper);
    // query for show
    int showId = histrionics.getShowId();
    QueryWrapper<Shows> showsQueryWrapper = new QueryWrapper<>();
    showsQueryWrapper.eq("show_id", showId);
    Shows shows = showsMapper.selectOne(showsQueryWrapper);
    // package for data
    data.put("shows", shows);
    data.put("histrionics", histrionics);

    response.put("status", "success");
    response.put("message", data.size());
    response.put("data", data);
    return response;
  }

  @Override
  public Map<String, Object> getAllHistrionics() {
    Map<String, Object> response = new HashMap<>();
    List<Histrionics> histrionicsList = histrionicsMapper.selectList(null);
    response.put("status", "success");
    response.put("message", histrionicsList.size());
    response.put("data", histrionicsList);
    return response;
  }

}
