package com.ticket.ticketsystem.service.impl.utils.assembler;

import com.ticket.ticketsystem.pojo.Ticket;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.server.RepresentationModelAssembler;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class TicketModelAssembler implements RepresentationModelAssembler<Ticket, EntityModel<Ticket>> {
    @Override
    public EntityModel<Ticket> toModel(Ticket ticket) {
        return EntityModel.of(ticket);
    }

    public CollectionModel<EntityModel<Ticket>> toCollectionModel(List<Ticket> ticketList){
        List<EntityModel<Ticket>> entityModelList=ticketList.stream()
                .map(this::toModel)
                .collect(Collectors.toList());

        return CollectionModel.of(entityModelList);
    }
}
