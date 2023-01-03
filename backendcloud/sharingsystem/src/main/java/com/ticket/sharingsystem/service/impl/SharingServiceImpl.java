package com.ticket.sharingsystem.service.impl;

import com.ticket.sharingsystem.pojo.Comment;
import com.ticket.sharingsystem.pojo.Sharing;
import com.ticket.sharingsystem.repository.SharingRepository;
import com.ticket.sharingsystem.service.SharingService;
import com.ticket.sharingsystem.service.impl.utils.assembler.SharingModelAssembler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
/**
 * @author: VenusHui
 * @description: TODO
 * @date: 2022/12/27 22:59
 * @version: 1.0
 */
public class SharingServiceImpl implements SharingService {

    @Autowired
    SharingRepository repository;

    private SharingModelAssembler assembler;

    public SharingServiceImpl(SharingModelAssembler assembler) {
        this.assembler = assembler;
    }

    @Override
    public Map<String, Object> getAll() {
        Map<String, Object> response = new HashMap<>();
        List<Sharing> sharings = repository.findAll();

        response.put("status", "success");
        response.put("message", "");
        response.put("data", assembler.toCollectionModel(sharings));
        return response;
    }

    @Override
    public Map<String, Object> getSharing(String sharingId) {
        Map<String, Object> response = new HashMap<>();
        Optional<Sharing> sharing = repository.findById(sharingId);
        if (sharing.isEmpty()) {
            response.put("status", "error");
            response.put("message", "_id 为" + sharingId + " 的 sharing 不存在");
            return response;
        }

        response.put("status", "success");
        response.put("message", "");
        response.put("data", assembler.toModel(sharing.get()));
        return response;
    }

    @Override
    public Map<String, Object> addSharing(Integer userId, Integer histrionicsId, String context, String imageUrl) {
        Map<String, Object> response = new HashMap<>();
        Sharing sharing = new Sharing(null, histrionicsId, userId, context, imageUrl, 0, 0, new Date(), new ArrayList<Comment>( ));
        repository.insert(sharing);

        response.put("status", "success");
        response.put("message", "添加分享成功");
        response.put("data", assembler.toModel(sharing));
        return response;
    }

    @Override
    public Map<String, Object> setSharing(String sharingId, String context, String imageUrl, Integer stars, Integer likes) {
        Map<String, Object> response = new HashMap<>();
        Optional<Sharing> sharing = repository.findById(sharingId);
        if (sharing.isEmpty()) {
            response.put("status", "error");
            response.put("message", "_id 为" + sharingId + " 的 sharing 不存在");
            return response;
        }
        if(context!=null)
            sharing.get().setContext(context);
        if(imageUrl!=null)
            sharing.get().setImageUrl(imageUrl);
        if(stars!=null)
            sharing.get().setStars(stars);
        if(likes!=null)
            sharing.get().setLikes(likes);

        response.put("status", "success");
        response.put("message", "修改成功");
        response.put("data", assembler.toModel(sharing.get()));
        return response;
    }

    @Override
    public Map<String, Object> getSharingsByUserId(Integer userId) {
        Map<String, Object> response = new HashMap<>();
        List<Sharing> sharings = repository.findByUserId(userId);

        response.put("status", "success");
        response.put("message", "");
        response.put("data", assembler.toCollectionModel(sharings));
        return response;
    }

    @Override
    public Map<String, Object> getSharingsByHistrionicsId(Integer histrionicsId) {
        Map<String, Object> response = new HashMap<>();
        List<Sharing> sharings = repository.findByHistrionicsId(histrionicsId);

        response.put("status", "success");
        response.put("message", "");
        response.put("data", assembler.toCollectionModel(sharings));
        return response;
    }


}
