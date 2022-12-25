package com.ticket.sharingsystem.service.impl.utils.assembler;

import com.ticket.sharingsystem.pojo.Sharing;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.server.RepresentationModelAssembler;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class SharingModelAssembler implements RepresentationModelAssembler<Sharing, EntityModel<Sharing>> {
    @Override
    public EntityModel<Sharing> toModel(Sharing sharing) {
        return EntityModel.of(sharing);
    }

    public CollectionModel<EntityModel<Sharing>> toCollectionModel(List<Sharing> sharingList){
        List<EntityModel<Sharing>> entityModelList=sharingList.stream()
                .map(this::toModel)
                .collect(Collectors.toList());

        return CollectionModel.of(entityModelList);
    }
}
