package com.ticket.ticketsystem.controller.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ticket.ticketsystem.pojo.Purchase;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PurchaseMapper extends BaseMapper<Purchase> {
}
