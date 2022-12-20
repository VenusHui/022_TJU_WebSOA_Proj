package com.ticket.ticketsystem.service.impl.utils.assembler;

import com.ticket.ticketsystem.controller.OrderTicketController;
import com.ticket.ticketsystem.pojo.Orders;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.server.RepresentationModelAssembler;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.methodOn;

/**
 * @author: VenusHui
 * @description: TODO
 * @date: 2022/12/20 16:11
 * @version: 1.0
 */
@Component
public class OrdersModelAssembler implements RepresentationModelAssembler<Orders, EntityModel<Orders>> {

    @Override
    public EntityModel<Orders> toModel(Orders orders) {
        return EntityModel.of(orders,
                linkTo(methodOn(OrderTicketController.class).getTicketsByOrderId(orders.getOrderId())).withRel("tickets"));
    }

    public CollectionModel<EntityModel<Orders>> toCollectionModel(List<Orders> ordersList) {
        List<EntityModel<Orders>> entityModelList = ordersList.stream()
                .map(this::toModel)
                .collect(Collectors.toList());

        return CollectionModel.of(entityModelList);
    }
}
