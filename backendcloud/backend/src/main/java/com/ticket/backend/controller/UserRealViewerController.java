package com.ticket.backend.controller;

import com.ticket.backend.service.user.UserRealViewerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserRealViewerController {
    @Autowired
    UserRealViewerService userRealViewerService;

    @GetMapping("/users/{userId}")
    public ResponseEntity<Object> getRealViewerByUserId(@PathVariable Integer userId){
        return ResponseEntity.ok(userRealViewerService.getRealViewerByUserId(userId));
    }
}
