package com.ticket.sharingsystem.controller;

import com.ticket.sharingsystem.service.SharingUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SharingUserController {
    @Autowired
    SharingUserService sharingUserService;

    @GetMapping("/sharings/{sharingId}")
    public ResponseEntity<Object> getUserCommentBySharingId(@PathVariable Integer sharingId){
        return ResponseEntity.ok(sharingUserService.getUserCommentBySharingId(sharingId));
    }
}
