package com.ticket.ticketsystem.controller;

import com.ticket.ticketsystem.service.KeywordShowsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class KeywordShowsController {
    @Autowired
    KeywordShowsService keywordShowsService;

    @GetMapping("/search")
    public ResponseEntity<Object> getShowsByKeyword(String keyword){
        return ResponseEntity.ok(keywordShowsService.getShowsByKeyword(keyword));
    }
}