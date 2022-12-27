package com.ticket.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.backend.mapper.RealViewerMapper;
import com.ticket.backend.pojo.RealViewer;
import com.ticket.backend.service.impl.utils.assembler.RealViewerModelAssembler;
import com.ticket.backend.service.user.UserRealViewerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserRealViewerServiceImpl implements UserRealViewerService {
    @Autowired
    RealViewerMapper realViewerMapper;

    private final RealViewerModelAssembler realViewerModelAssembler;

    public UserRealViewerServiceImpl(RealViewerModelAssembler realViewerModelAssembler){
        this.realViewerModelAssembler = realViewerModelAssembler;
    }

    @Override
    public Map<String, Object> getRealViewerByUserId(Integer userId){
        Map<String, Object> response = new HashMap<>();

        QueryWrapper<RealViewer> realViewerQueryWrapper = new QueryWrapper<>();
        realViewerQueryWrapper.eq("user_id", userId);
        List<RealViewer> realViewerList = realViewerMapper.selectList(realViewerQueryWrapper);

        response.put("status", "success");
        response.put("message",realViewerList.size());
        response.put("data",realViewerModelAssembler.toCollectionModel(realViewerList));

        return response;
    }
}
