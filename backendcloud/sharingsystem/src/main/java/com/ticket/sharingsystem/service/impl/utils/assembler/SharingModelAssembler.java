package com.ticket.sharingsystem.service.impl.utils.assembler;

import com.ticket.sharingsystem.controller.CommentController;
import com.ticket.sharingsystem.controller.SharingController;
import com.ticket.sharingsystem.pojo.Sharing;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.server.RepresentationModelAssembler;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.methodOn;

@Component
public class SharingModelAssembler implements RepresentationModelAssembler<Sharing, EntityModel<Sharing>> {
    @Override
    public EntityModel<Sharing> toModel(Sharing sharing) {
        return EntityModel.of(sharing,
                linkTo(methodOn(SharingController.class).getSharing(sharing.get_id())).withSelfRel(),
                linkTo(methodOn(SharingController.class).getSharings("all", 0)).withRel("all sharings"),
                linkTo(methodOn(CommentController.class).getComments(sharing.get_id(), "all", 0)).withRel("all comments"));
    }

    public CollectionModel<EntityModel<Sharing>> toCollectionModel(List<Sharing> sharingList) {
        List<EntityModel<Sharing>> entityModelList = sharingList.stream()
                .map(this::toModel)
                .collect(Collectors.toList());

        return CollectionModel.of(entityModelList);
    }
}
