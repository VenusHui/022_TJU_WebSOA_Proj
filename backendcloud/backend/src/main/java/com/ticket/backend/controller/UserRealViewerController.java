package com.ticket.backend.controller;

import com.ticket.backend.service.user.UserRealViewerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
public class UserRealViewerController {
    @Autowired
    UserRealViewerService userRealViewerService;

    @GetMapping("/users/{userId}")
    public ResponseEntity<Object> getRealViewerByUserId(@PathVariable Integer userId){
        return ResponseEntity.ok(userRealViewerService.getRealViewerByUserId(userId));
    }

    @PostMapping("/realviewers/")
    public ResponseEntity<Object> addRealViewer(@RequestParam Map<String, Object> form){
        String atr1 = form.get("user_id").toString();
        String identityNumber = form.get("identity_number").toString();
        String name = form.get("name").toString();

        Integer userId = Integer.valueOf(atr1);

        return ResponseEntity.ok(userRealViewerService.addRealViewer(userId, identityNumber, name));
    }
    @DeleteMapping("/realviewers/")
    public ResponseEntity<Object> delRealViewer(@RequestParam Map<String, Object> form){
        String atr1 = form.get("user_id").toString();
        String identityNumber = form.get("identity_number").toString();
        String name = form.get("name").toString();

        Integer userId = Integer.valueOf(atr1);

        return ResponseEntity.ok(userRealViewerService.delRealViewer(userId, identityNumber, name));
    }
}
