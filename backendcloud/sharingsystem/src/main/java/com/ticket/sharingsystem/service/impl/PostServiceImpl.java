package com.ticket.sharingsystem.service.impl;

import com.ticket.sharingsystem.pojo.Post;
import com.ticket.sharingsystem.repository.PostRepository;
import com.ticket.sharingsystem.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
/**
 * @author: VenusHui
 * @description: TODO
 * @date: 2022/12/27 22:59
 * @version: 1.0
 */
public class PostServiceImpl implements PostService {

    @Autowired
    PostRepository repository;

    @Override
    public Map<String, Object> getAll() {
        Map<String, Object> response = new HashMap<>();
        List<Post> posts = repository.findAll();
        System.out.println(posts);

        response.put("status", "success");
        response.put("message", "");
        response.put("data", posts);
        return response;
    }
}
