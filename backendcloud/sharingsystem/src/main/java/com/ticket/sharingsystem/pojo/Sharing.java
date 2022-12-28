package com.ticket.sharingsystem.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;
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
public class Sharing {
    @Id
    private String _id;
    private Integer histrionicsId;
    private Integer userId;
    private String context;
    private String imageUrl;
    private Integer stars;
    private Integer likes;
    private Date shareDate;
    private List<Comment> comments;
}
