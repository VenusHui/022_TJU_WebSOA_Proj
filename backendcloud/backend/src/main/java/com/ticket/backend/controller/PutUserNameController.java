package com.ticket.backend.controller;

import com.ticket.backend.service.user.PutUserNameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class PutUserNameController {
    @Autowired
    PutUserNameService putUserNameService;

    @PutMapping("/users/{userId}/name")
    public ResponseEntity<Object> putUserName(@PathVariable Integer userId, @RequestParam Map<String, Object> form){
        String newName = form.get("new_name").toString();
        return ResponseEntity.ok(putUserNameService.putUserName(userId, newName));
    }
}
