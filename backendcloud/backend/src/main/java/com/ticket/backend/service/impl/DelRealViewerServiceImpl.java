package com.ticket.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.backend.mapper.RealViewerMapper;
import com.ticket.backend.pojo.RealViewer;
import com.ticket.backend.service.impl.utils.assembler.RealViewerModelAssembler;
import com.ticket.backend.service.user.DelRealViewerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class DelRealViewerServiceImpl implements DelRealViewerService {
    @Autowired
    RealViewerMapper realViewerMapper;

    private final RealViewerModelAssembler realViewerModelAssembler;

    public DelRealViewerServiceImpl(RealViewerModelAssembler realViewerModelAssembler){
        this.realViewerModelAssembler = realViewerModelAssembler;
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
