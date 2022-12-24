package com.ticket.ticketsystem.controller;

import com.ticket.ticketsystem.service.ShowDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ShowDetailController {
    @Autowired
    ShowDetailService showDetailService;

    @GetMapping("/shows/{showId}")
    public ResponseEntity<Object> getShowDetailByShowId(@PathVariable Integer showId){
        return ResponseEntity.ok(showDetailService.getShowDetailByShowId(showId));
    }
}
