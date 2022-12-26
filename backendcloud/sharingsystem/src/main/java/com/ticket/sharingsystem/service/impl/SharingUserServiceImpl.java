package com.ticket.sharingsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.sharingsystem.mapper.CommentMapper;
import com.ticket.sharingsystem.mapper.SharingMapper;
import com.ticket.sharingsystem.pojo.Comment;
import com.ticket.sharingsystem.pojo.Sharing;
import com.ticket.sharingsystem.service.SharingUserService;
import com.ticket.sharingsystem.service.impl.utils.assembler.CommentModelAssembler;
import com.ticket.sharingsystem.service.impl.utils.assembler.SharingModelAssembler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SharingUserServiceImpl implements SharingUserService {
    @Autowired
    SharingMapper sharingMapper;

    @Autowired
    CommentMapper commentMapper;

    private SharingModelAssembler sharingModelAssembler;

    private CommentModelAssembler commentModelAssembler;


    public SharingUserServiceImpl(SharingModelAssembler sharingModelAssembler, CommentModelAssembler commentModelAssembler){
        this.sharingModelAssembler = sharingModelAssembler;
        this.commentModelAssembler = commentModelAssembler;
    }

    @Override
    public Map<String,Object> getUserCommentBySharingId(Integer sharingId){
        Map<String,Object> response = new HashMap<>();

        QueryWrapper<Sharing> sharingQueryWrapper = new QueryWrapper<>();
        sharingQueryWrapper.eq("sharing_id",sharingId);
        Sharing sharing = sharingMapper.selectOne(sharingQueryWrapper);


        QueryWrapper<Comment> commentQueryWrapper = new QueryWrapper<>();
        commentQueryWrapper.eq("sharing_id",sharingId);
        List<Comment> commentList = commentMapper.selectList(commentQueryWrapper);

        Map<String,Object> data = new HashMap<>();
        data.put("sharing",sharingModelAssembler.toModel(sharing));
        data.put("user_id",sharing.getUserId());
        data.put("comments",commentModelAssembler.toCollectionModel(commentList));

        response.put("status","success");
        response.put("message",data.size());
        response.put("data",data);

        return response;
    }
}

