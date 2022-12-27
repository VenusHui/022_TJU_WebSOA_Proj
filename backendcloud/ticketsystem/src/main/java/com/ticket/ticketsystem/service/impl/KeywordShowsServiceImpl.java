package com.ticket.ticketsystem.service.impl;

import com.ticket.ticketsystem.service.KeywordShowsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.ShowsMapper;
import com.ticket.ticketsystem.pojo.Shows;
import com.ticket.ticketsystem.service.KeywordShowsService;
import com.ticket.ticketsystem.service.impl.utils.assembler.ShowsModelAssembler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class KeywordShowsServiceImpl implements KeywordShowsService {
    @Autowired
    ShowsMapper showsMapper;

    private ShowsModelAssembler showsModelAssembler;

    public KeywordShowsServiceImpl(ShowsModelAssembler showsModelAssembler){
        this.showsModelAssembler = showsModelAssembler;
    }

    @Override
    public Map<String,Object> getShowsByKeyword(String keyword){
        Map<String,Object> response = new HashMap<>();

        List<Shows> allShowsList = showsMapper.selectList(null);

        List<Shows> showsList = new ArrayList<>();

        // 进行字符串子串包含匹配
        for(int i = 0; i < allShowsList.size(); i++) {
            if (allShowsList.get(i).getTitle().contains(keyword)) {
                showsList.add(allShowsList.get(i));
            }
        }

        response.put("status","success");
        response.put("message",showsList.size());
        response.put("data",showsModelAssembler.toCollectionModel(showsList));

        return response;
    }
}
