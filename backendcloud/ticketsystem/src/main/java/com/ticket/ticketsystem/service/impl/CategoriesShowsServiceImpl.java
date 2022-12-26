package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.ShowsMapper;
import com.ticket.ticketsystem.pojo.Shows;
import com.ticket.ticketsystem.service.CategoriesShowsService;
import com.ticket.ticketsystem.service.impl.utils.assembler.ShowsModelAssembler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CategoriesShowsServiceImpl implements CategoriesShowsService {
    @Autowired
    ShowsMapper showsMapper;

    private ShowsModelAssembler showsModelAssembler;

    public CategoriesShowsServiceImpl(ShowsModelAssembler showsModelAssembler){
        this.showsModelAssembler = showsModelAssembler;
    }

    @Override
    public Map<String,Object> getShowDetailByCategories(String categories){
        Map<String,Object> response = new HashMap<>();

        QueryWrapper<Shows> showsQueryWrapper = new QueryWrapper<>();
        showsQueryWrapper.eq("categories",categories);
        List<Shows> showsList = showsMapper.selectList(showsQueryWrapper);

        response.put("status","success");
        response.put("message",showsList.size());
        response.put("data",showsModelAssembler.toCollectionModel(showsList));

        return response;
    }
}
