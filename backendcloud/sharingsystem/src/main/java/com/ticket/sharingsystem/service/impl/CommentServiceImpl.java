package com.ticket.sharingsystem.service.impl;

import com.alibaba.nacos.shaded.org.checkerframework.checker.units.qual.C;
import com.ticket.sharingsystem.pojo.Comment;
import com.ticket.sharingsystem.pojo.Sharing;
import com.ticket.sharingsystem.repository.SharingRepository;
import com.ticket.sharingsystem.service.CommentService;
import com.ticket.sharingsystem.service.impl.utils.assembler.CommentModelAssembler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
/**
 * @author: VenusHui
 * @description: TODO
 * @date: 2022/12/28 15:36
 * @version: 1.0
 */
public class CommentServiceImpl implements CommentService {

    @Autowired
    SharingRepository repository;

    private CommentModelAssembler assembler;

    public CommentServiceImpl(CommentModelAssembler assembler) {
        this.assembler = assembler;
    }

    @Override
    public Map<String, Object> getAll(String sharingId) {
        Map<String, Object> response = new HashMap<>();
        Optional<Sharing> sharing = repository.findById(sharingId);
        if (sharing.isEmpty()) {
            response.put("status", "error");
            response.put("message", "_id 为" + sharingId + " 的 sharing 不存在");
            return response;
        }
        List<Comment> comments = sharing.get().getComments().stream()
                .map(o -> (Comment) o)
                .collect(Collectors.toList());

        response.put("status", "success");
        response.put("message", "");
        response.put("data", assembler.toCollectionModel(comments));
        return response;
    }

    @Override
    public Map<String, Object> addComment(String sharingId, Integer userId, String context) {
        Map<String, Object> response = new HashMap<>();
        Optional<Sharing> sharing = repository.findById(sharingId);
        if (sharing.isEmpty()) {
            response.put("status", "error");
            response.put("message", "_id 为" + sharingId + " 的 sharing 不存在");
            return response;
        }
        Comment comment = new Comment(userId, context, 0, new Date());
        sharing.get().getComments().add(comment);
        repository.save(sharing.get());

        response.put("status", "success");
        response.put("message", "添加评论成功");
        response.put("data", assembler.toModel(comment));
        return response;
    }

    @Override
    public Map<String, Object> getCommentsByUserId(String sharingId, Integer userId) {
        Map<String, Object> response = new HashMap<>();
        Optional<Sharing> sharing = repository.findById(sharingId);
        if (sharing.isEmpty()) {
            response.put("status", "error");
            response.put("message", "_id 为" + sharingId + " 的 sharing 不存在");
            return response;
        }
        List<Comment> comments = sharing.get().getComments().stream()
                .map(o -> (Comment) o)
                .collect(Collectors.toList());

        response.put("status", "success");
        response.put("message", "");
        response.put("data", assembler.toCollectionModel(comments));
        return response;
    }


}
