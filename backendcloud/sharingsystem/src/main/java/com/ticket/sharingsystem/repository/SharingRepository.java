package com.ticket.sharingsystem.repository;

import com.ticket.sharingsystem.pojo.Sharing;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SharingRepository extends MongoRepository<Sharing, String> {
    List<Sharing> findByUserId(Integer userId);

    List<Sharing> findByHistrionicsId(Integer histrionicsId);
}
