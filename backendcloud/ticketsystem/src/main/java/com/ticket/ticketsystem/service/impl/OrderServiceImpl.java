package com.ticket.ticketsystem.service.impl;

import com.alibaba.nacos.shaded.org.checkerframework.checker.units.qual.A;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.OrdersMapper;
import com.ticket.ticketsystem.mapper.PurchaseMapper;
import com.ticket.ticketsystem.mapper.TicketMapper;
import com.ticket.ticketsystem.mapper.TicketStallMapper;
import com.ticket.ticketsystem.pojo.Orders;
import com.ticket.ticketsystem.pojo.Purchase;
import com.ticket.ticketsystem.pojo.Ticket;
import com.ticket.ticketsystem.pojo.TicketStall;
import com.ticket.ticketsystem.service.OrderService;
import com.ticket.ticketsystem.service.TicketService;
import com.ticket.ticketsystem.service.impl.utils.assembler.OrdersModelAssembler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
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
    OrdersMapper ordersMapper;
    @Autowired
    TicketStallMapper ticketStallMapper;
    @Autowired
    TicketMapper ticketMapper;
    @Autowired
    PurchaseMapper purchaseMapper;

    private final OrdersModelAssembler ordersModelAssembler;

    public OrderServiceImpl(OrdersModelAssembler ordersModelAssembler) {
        this.ordersModelAssembler = ordersModelAssembler;
    }


    @Override
    public Map<String, Object> getOrderByUserId(Integer userId) {
        Map<String, Object> response = new HashMap<>();
        QueryWrapper<Orders> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        List<Orders> orderList = ordersMapper.selectList(queryWrapper);

        response.put("status", "success");
        response.put("message", orderList.size());
        response.put("data", ordersModelAssembler.toCollectionModel(orderList));
        return response;
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
    @Override
    public Map<String, Object> postOrder(Integer userId,Integer ticketStallId, Integer num, List<String> viewers) {
        Map<String,Object> response=new HashMap<>();
        if(num==null||viewers==null){
            response.put("status","error");
            response.put("message","参数不能为空");
            return response;
        }
        if(num<=0){
            response.put("status","error");
            response.put("message","购票数目必须为正整数");
            return response;
        }
        if(num!=viewers.size()){
            response.put("status","error");
            response.put("message","错误的参数个数");
            return response;
        }

        QueryWrapper<TicketStall> ticketStallQueryWrapper=new QueryWrapper<>();
        ticketStallQueryWrapper.eq("ticket_stall_id",ticketStallId);
        TicketStall ticketStall=ticketStallMapper.selectOne(ticketStallQueryWrapper);

        if(ticketStall.getRemaining()<num){
            response.put("status","error");
            response.put("message","剩余库存不足");
            return response;
        }

        int remaining=ticketStall.getRemaining();
        int sold=ticketStall.getSold();

        ticketStall.setRemaining(remaining-num);
        ticketStall.setSold(sold+num);

        ticketStallMapper.update(ticketStall,ticketStallQueryWrapper);

        double totalPrice=num*ticketStall.getPrice();
        Orders orders=new Orders(null,userId, new Timestamp(System.currentTimeMillis()),null,1,totalPrice,ticketStall.getHistrionicsId());
        ordersMapper.insert(orders);
        for(int i=0;i<num;i++){
            Ticket ticket=new Ticket(null,ticketStallId,viewers.get(i),null,1);
            ticketMapper.insert(ticket);
            Purchase purchase=new Purchase(orders.getOrderId(), ticket.getTicketId());
            purchaseMapper.insert(purchase);
        }

        response.put("status","success");
        response.put("message","订单创建成功");
        response.put("data",orders);

        return response;
    }
}
