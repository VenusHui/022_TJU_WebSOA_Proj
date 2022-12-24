package com.ticket.ticketsystem.service.impl.utils.assembler;

import com.ticket.ticketsystem.pojo.Shows;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.server.RepresentationModelAssembler;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;


@Component
public class ShowsModelAssembler implements RepresentationModelAssembler<Shows, EntityModel<Shows>> {
    @Override
    public EntityModel<Shows> toModel(Shows shows) {
        return EntityModel.of(shows);
    }

    public CollectionModel<EntityModel<Shows>> toCollectionModel(List<Shows> showsList){
        List<EntityModel<Shows>> entityModelList=showsList.stream()
                .map(this::toModel)
                .collect(Collectors.toList());

        return CollectionModel.of(entityModelList);
    }
}
