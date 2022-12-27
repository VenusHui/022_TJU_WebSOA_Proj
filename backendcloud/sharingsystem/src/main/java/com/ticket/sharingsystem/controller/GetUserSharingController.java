package com.ticket.sharingsystem.controller;

import com.ticket.sharingsystem.service.GetUserSharingService;
import com.ticket.sharingsystem.service.SharingUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GetUserSharingController {
    @Autowired
    GetUserSharingService getUserSharingService;

    @GetMapping("/users/{userId}/sharings")
    public ResponseEntity<Object> getUserCommentBySharingId(@PathVariable Integer userId){
        return ResponseEntity.ok(getUserSharingService.getUserSharingByUserId(userId));
    }
}
