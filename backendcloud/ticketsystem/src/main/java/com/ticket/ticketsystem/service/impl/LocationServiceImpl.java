package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.HistrionicsMapper;
import com.ticket.ticketsystem.mapper.LocationMapper;
import com.ticket.ticketsystem.mapper.ShowsMapper;
import com.ticket.ticketsystem.pojo.Histrionics;
import com.ticket.ticketsystem.pojo.Location;
import com.ticket.ticketsystem.pojo.Shows;
import com.ticket.ticketsystem.service.LocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Neo
 * @version 1.0
 */
@Service
public class LocationServiceImpl implements LocationService {

    @Autowired
    LocationMapper locationMapper;
    @Autowired
    HistrionicsMapper histrionicsMapper;
    @Autowired
    ShowsMapper showsMapper;
    @Override
    public Map<String, Object> getAllLocations() {
        Map<String,Object> response=new HashMap<>();
        List<Location> locations=locationMapper.selectList(null);
        response.put("status","success");
        response.put("message",locations.size());
        response.put("data",locations);
        return response;
    }

    @Override
    public Map<String, Object> getLocationsByLocationId(Integer locationId) {
        Map<String,Object> response=new HashMap<>();
        QueryWrapper<Location> locationQueryWrapper=new QueryWrapper<>();
        locationQueryWrapper.eq("location_id",locationId);
        Location location=locationMapper.selectOne(locationQueryWrapper);
        if(location==null){
            response.put("status","error");
            response.put("message","没有对应的地点");
            return response;
        }
        response.put("status","success");
        response.put("message","");
        response.put("data",location);
        return response;
    }

    @Override
    public Map<String, Object> getShowsInfoByLocationId(Integer locationId) {
        Map<String,Object> response=new HashMap<>();
        List<Object> data=new ArrayList<>();
        // query for histrionics
        QueryWrapper<Histrionics> histrionicsQueryWrapper=new QueryWrapper<>();
        histrionicsQueryWrapper.eq("location_id",locationId);
        List<Histrionics> histrionicsList=histrionicsMapper.selectList(histrionicsQueryWrapper);
        // query for shows
        for(int i=0;i<histrionicsList.size();i++){
            List<Object> shows_info=new ArrayList<>();
            QueryWrapper<Shows> showsQueryWrapper=new QueryWrapper<>();
            showsQueryWrapper.eq("show_id",histrionicsList.get(i).getShowId());
            Shows shows=showsMapper.selectOne(showsQueryWrapper);
            shows_info.add(shows);
            shows_info.add(histrionicsList.get(i));
            data.add(shows_info);
        }
        // package for response
        response.put("status","success");
        response.put("message",data.size());
        response.put("data",data);
        return response;
    }

    @Override
    public Map<String, Object> getLocationsByHistrionicsId(Integer histrionicsId) {
        Map<String,Object> response=new HashMap<>();
        // query for histrionics
        QueryWrapper<Histrionics> histrionicsQueryWrapper=new QueryWrapper<>();
        histrionicsQueryWrapper.eq("histrionics_id",histrionicsId);
        Histrionics histrionics=histrionicsMapper.selectOne(histrionicsQueryWrapper);
        // query for location
        QueryWrapper<Location> locationQueryWrapper=new QueryWrapper<>();
        locationQueryWrapper.eq("location_id",histrionics.getLocationId());
        Location location=locationMapper.selectOne(locationQueryWrapper);
        // package for response
        response.put("status","success");
        response.put("data",location);
        return response;
    }
}
