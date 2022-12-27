package com.ticket.sharingsystem.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.sql.Timestamp;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document("sharing")
/**
 * @author: VenusHui
 * @description: TODO
 * @date: 2022/12/27 22:54
 * @version: 1.0
 */
public class Post {
    @Id
    private String _id;
    private String sharingId;
    private String userId;
    private String context;
    private String imageUrl;
    private String stars;
    private String likes;
    private Timestamp shareDate;
    private List<Object> comments;
}
