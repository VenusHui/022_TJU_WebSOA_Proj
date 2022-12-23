package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.OrdersMapper;
import com.ticket.ticketsystem.pojo.Orders;
import com.ticket.ticketsystem.service.OrderDetailsService;
import com.ticket.ticketsystem.service.impl.utils.assembler.OrdersModelAssembler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class OrderDetailsImpl implements OrderDetailsService {

    @Autowired
    OrdersMapper ordersMapper;

    private final OrdersModelAssembler ordersModelAssembler;

    public OrderDetailsImpl(OrdersModelAssembler ordersModelAssembler) {
        this.ordersModelAssembler = ordersModelAssembler;
    }


    @Override
    public Map<String, Object> getOrderDetailsByOrderId(Integer orderId) {
        Map<String, Object> response = new HashMap<>();

        QueryWrapper<Orders> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("order_id", orderId);
        Orders order = ordersMapper.selectOne(queryWrapper);

        Map<String, Object> data = new HashMap<>();
        data.put("order", ordersModelAssembler.toModel(order));

        response.put("status", "success");
        response.put("message", data.size());
        response.put("data", data);
        return response;
    }

}
