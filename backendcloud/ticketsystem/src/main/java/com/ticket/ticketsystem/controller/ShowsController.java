package com.ticket.ticketsystem.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.ShowsMapper;
import com.ticket.ticketsystem.pojo.Shows;
import com.ticket.ticketsystem.service.ShowsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class ShowsController {
    @Autowired
    ShowsService showsService;

    @GetMapping("/shows/{showId}/")
    public ResponseEntity<Object> getShowDetailByShowId(@PathVariable Integer showId){
        return ResponseEntity.ok(showsService.getShowDetailByShowId(showId));
    }
    @GetMapping("/users/{userId}/ticket_stall/{ticketStallId}/")
    public ResponseEntity<Object> getTicketStall(@PathVariable Integer ticketStallId){
        return ResponseEntity.ok(showsService.getTicketStall(ticketStallId));
    }
    @GetMapping("/search/")
    public ResponseEntity<Object> getShowsByKeyword(String keyword){
        return ResponseEntity.ok(showsService.getShowsByKeyword(keyword));
    }
    @GetMapping("/shows/")
    public ResponseEntity<Object> getShowDetailByCategories(String categories){
        return ResponseEntity.ok(showsService.getShowDetailByCategories(categories));
    }
    @GetMapping("/histrionics/{histrionicsId}/ticket_stall/")
    public ResponseEntity<Object> getTicketStallByHistrionics(@PathVariable Integer histrionicsId){
        return ResponseEntity.ok(showsService.getTicketStallByHistrionics(histrionicsId));
    }

    @GetMapping("/histrionics/{histrionicsId}/show/")
    public ResponseEntity<Object> getShowByHistrionics(@PathVariable Integer histrionicsId){
        return ResponseEntity.ok(showsService.getShowByHistrionics(histrionicsId));
    }
    @GetMapping("/histrionics/")
    public ResponseEntity<Object> getAllHistrionics(){
        return ResponseEntity.ok(showsService.getAllHistrionics());
    }

    @GetMapping("/shows1/")
    public ResponseEntity<Object> getShows1() {
        return ResponseEntity.ok(showsService.getShowDetailByCategories("喜剧"));
    }

    @GetMapping("/shows2/")
    public ResponseEntity<Object> getShows2() {
        return ResponseEntity.ok(showsService.getShows1to5());
    }

}
