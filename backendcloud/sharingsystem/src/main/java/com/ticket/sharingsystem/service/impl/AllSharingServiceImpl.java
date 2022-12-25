package com.ticket.sharingsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.sharingsystem.mapper.SharingMapper;
import com.ticket.sharingsystem.pojo.Sharing;
import com.ticket.sharingsystem.service.AllSharingService;
import com.ticket.sharingsystem.service.impl.utils.assembler.SharingModelAssembler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AllSharingServiceImpl implements AllSharingService {
    @Autowired
    SharingMapper sharingMapper;

    private final SharingModelAssembler sharingModelAssembler;

    public AllSharingServiceImpl(SharingModelAssembler sharingModelAssembler){
        this.sharingModelAssembler = sharingModelAssembler;
    }


    @Override
    public Map<String, Object> getAllSharing() {
        Map<String, Object> response = new HashMap<>();
        List<Sharing> sharingList = sharingMapper.selectList(null);
        System.out.println("test");
        System.out.println(sharingList);
        response.put("status", "success");
        response.put("message", "1");
        response.put("data", sharingModelAssembler.toCollectionModel(sharingList));
        return response;
    }
}
