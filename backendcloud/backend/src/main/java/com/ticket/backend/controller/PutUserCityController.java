package com.ticket.backend.controller;

import com.ticket.backend.service.user.PutUserCityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class PutUserCityController {
    @Autowired
    PutUserCityService putUserCityService;


    @PutMapping("/users/{userId}/city")
    public ResponseEntity<Object> putUserName(@PathVariable Integer userId, @RequestParam Map<String, Object> form){
        String newCity = form.get("new_city").toString();
        return ResponseEntity.ok(putUserCityService.putUserCity(userId, newCity));
    }
}
