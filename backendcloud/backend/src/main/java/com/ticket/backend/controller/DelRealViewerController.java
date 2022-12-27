package com.ticket.backend.controller;

import com.ticket.backend.service.user.AddRealViewerService;
import com.ticket.backend.service.user.DelRealViewerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class DelRealViewerController {
    @Autowired
    DelRealViewerService delRealViewerService;

    @DeleteMapping("/realviewers1")
    public ResponseEntity<Object> addRealViewer(@RequestParam Map<String, Object> form){
        String atr1 = form.get("user_id").toString();
        String identityNumber = form.get("identity_number").toString();
        String name = form.get("name").toString();

        Integer userId = Integer.valueOf(atr1);

        return ResponseEntity.ok(delRealViewerService.delRealViewer(userId, identityNumber, name));
    }
}
