package com.ticket.ticketsystem.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.OrdersMapper;
import com.ticket.ticketsystem.pojo.Orders;
import com.ticket.ticketsystem.service.OrderDetailService;
import com.ticket.ticketsystem.service.impl.utils.assembler.OrdersModelAssembler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class OrderDetailServiceImpl implements OrderDetailService {
    @Autowired
    OrdersMapper ordersMapper;

    private OrdersModelAssembler ordersModelAssembler;

    public OrderDetailServiceImpl(OrdersModelAssembler ordersModelAssembler){
        this.ordersModelAssembler = ordersModelAssembler;
    }

    @Override
    public Map<String, Object> getOrderDetailByOrderId(Integer orderId){
        Map<String,Object> response = new HashMap<>();

        QueryWrapper<Orders> ordersQueryWrapper = new QueryWrapper<>();
        ordersQueryWrapper.eq("order_id", orderId);
        Orders order = ordersMapper.selectOne(ordersQueryWrapper);

        response.put("status","success");
        response.put("message",'1');
        response.put("data",ordersModelAssembler.toModel(order));

        return response;
    }

}
