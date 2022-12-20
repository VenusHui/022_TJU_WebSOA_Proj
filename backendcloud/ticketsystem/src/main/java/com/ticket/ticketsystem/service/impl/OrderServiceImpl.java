package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.OrderMapper;
import com.ticket.ticketsystem.pojo.Order;
import com.ticket.ticketsystem.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author: VenusHui
 * @description: TODO
 * @date: 2022/12/20 15:06
 * @version: 1.0
 */
@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    OrderMapper orderMapper;

    @Override
    public Map<String, Object> getOrderByUserId(Integer userId) {
        Map<String, Object> response = new HashMap<>();
        QueryWrapper<Order> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        List<Order> orders = orderMapper.selectList(queryWrapper);

        response.put("status", "success");
        response.put("message", orders.size());
        response.put("data", orders);
        return response;
    }
}
