package com.ticket.sharingsystem.controller;

import com.ticket.sharingsystem.service.AllSharingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AllSharingController {

    @Autowired
    AllSharingService allSharingService;

    @GetMapping("/sharings")
    public ResponseEntity<Object> getAllSharing() {
        return ResponseEntity.ok(allSharingService.getAllSharing());
    }
}
