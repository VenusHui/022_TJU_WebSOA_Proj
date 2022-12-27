package com.ticket.sharingsystem.controller;

import com.ticket.sharingsystem.service.AddCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class AddCommentController {
    @Autowired
    AddCommentService addCommentService;

    @PostMapping("/comments")
    public ResponseEntity<Object> addComment(@RequestParam Map<String, Object> form){
        String atr1 = form.get("sharing_id").toString();
        String atr2 = form.get("user_id").toString();
        String context = form.get("context").toString();

        Integer sharingId = Integer.valueOf(atr1);
        Integer userId = Integer.valueOf(atr2);

        return ResponseEntity.ok(addCommentService.addComment(sharingId, userId, context));
    }
}
