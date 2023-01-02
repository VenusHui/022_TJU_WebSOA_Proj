package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.LocationMapper;
import com.ticket.ticketsystem.pojo.Location;
import com.ticket.ticketsystem.service.LocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
