package com.ticket.sharingsystem.service.impl;

import com.ticket.sharingsystem.mapper.CommentMapper;
import com.ticket.sharingsystem.pojo.Comment;
import com.ticket.sharingsystem.service.AddCommentService;
import com.ticket.sharingsystem.service.impl.utils.assembler.CommentModelAssembler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AddCommentServiceImpl implements AddCommentService {
    @Autowired
    CommentMapper commentMapper;

    private final CommentModelAssembler commentModelAssembler;

    public AddCommentServiceImpl(CommentModelAssembler commentModelAssembler){
        this.commentModelAssembler = commentModelAssembler;
    }

    @Override
    public Map<String, Object> addComment(Integer sharingId, Integer userId, String context){
        Map<String, Object> response = new HashMap<>();
        Comment comment = new Comment(null, sharingId, userId, context, 0);

        commentMapper.insert(comment);

        response.put("status", "success");
        response.put("message", "评论成功");
        response.put("data", commentModelAssembler.toModel(comment));

        return response;
    }
}
