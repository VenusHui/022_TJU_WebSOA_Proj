package com.ticket.sharingsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.sharingsystem.mapper.SharingMapper;
import com.ticket.sharingsystem.pojo.Sharing;
import com.ticket.sharingsystem.service.GetUserSharingService;
import com.ticket.sharingsystem.service.impl.utils.assembler.SharingModelAssembler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class GetUserSharingServiceImpl implements GetUserSharingService {
    @Autowired
    SharingMapper sharingMapper;

    private final SharingModelAssembler sharingModelAssembler;

    public GetUserSharingServiceImpl(SharingModelAssembler sharingModelAssembler){
        this.sharingModelAssembler = sharingModelAssembler;
    }


    @Override
    public Map<String, Object> getUserSharingByUserId(Integer userId) {
        Map<String, Object> response = new HashMap<>();

        QueryWrapper<Sharing> sharingQueryWrapper = new QueryWrapper<>();
        sharingQueryWrapper.eq("user_id", userId);
        List<Sharing> sharingList = sharingMapper.selectList(sharingQueryWrapper);

        response.put("status","success");
        response.put("message",sharingList.size());
        response.put("data",sharingModelAssembler.toCollectionModel(sharingList));

        return response;
    }
}
