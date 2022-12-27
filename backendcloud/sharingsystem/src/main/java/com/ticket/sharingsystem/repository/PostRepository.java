package com.ticket.sharingsystem.repository;

import com.ticket.sharingsystem.pojo.Post;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface PostRepository extends MongoRepository<Post, String> {
}
