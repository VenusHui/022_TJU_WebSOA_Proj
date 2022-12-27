package com.ticket.backend.service.impl;

import com.ticket.backend.mapper.RealViewerMapper;
import com.ticket.backend.pojo.RealViewer;
import com.ticket.backend.service.impl.utils.assembler.RealViewerModelAssembler;
import com.ticket.backend.service.user.AddRealViewerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class AddRealViewerServiceImpl implements AddRealViewerService {
    @Autowired
    RealViewerMapper realViewerMapper;

    private final RealViewerModelAssembler realViewerModelAssembler;

    public AddRealViewerServiceImpl(RealViewerModelAssembler realViewerModelAssembler){
        this.realViewerModelAssembler = realViewerModelAssembler;
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
}
