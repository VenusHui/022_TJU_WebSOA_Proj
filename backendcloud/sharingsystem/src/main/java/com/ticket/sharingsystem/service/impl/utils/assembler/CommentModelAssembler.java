package com.ticket.sharingsystem.service.impl.utils.assembler;

import com.ticket.sharingsystem.controller.CommentController;
import com.ticket.sharingsystem.controller.SharingController;
import com.ticket.sharingsystem.pojo.Comment;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.server.RepresentationModelAssembler;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.methodOn;

@Component
public class CommentModelAssembler implements RepresentationModelAssembler<Comment, EntityModel<Comment>> {
    @Override
    public EntityModel<Comment> toModel(Comment comment) {
        return EntityModel.of(comment);
    }

    public CollectionModel<EntityModel<Comment>> toCollectionModel(List<Comment> commentList) {
        List<EntityModel<Comment>> entityModelList = commentList.stream()
                .map(this::toModel)
                .collect(Collectors.toList());

        return CollectionModel.of(entityModelList);
    }
}
