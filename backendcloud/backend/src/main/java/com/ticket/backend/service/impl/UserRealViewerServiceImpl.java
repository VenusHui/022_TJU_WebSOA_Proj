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
    @Override
    public Map<String, Object> addRealViewer(Integer userId, String identityNumber, String name){
        Map<String, Object> response = new HashMap<>();
        RealViewer realViewer= new RealViewer(userId, identityNumber, null, name);

        realViewerMapper.insert(realViewer);

        response.put("status", "success");
        response.put("message", "添加观影人成功");
        response.put("data", realViewerModelAssembler.toModel(realViewer));

        return response;
    }

    @Override
    public Map<String, Object> delRealViewer(Integer userId, String identityNumber, String name){
        Map<String, Object> response = new HashMap<>();
        QueryWrapper<RealViewer> realViewerQueryWrapper = new QueryWrapper<>();
        realViewerQueryWrapper.eq("user_id",userId).eq("identity_number",identityNumber).eq("name",name);

        realViewerMapper.delete(realViewerQueryWrapper);

        response.put("status", "success");
        response.put("message", "删除观影人成功");
        response.put("data", null);

        return response;
    }

}
