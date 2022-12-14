package com.ticket.backend.service.impl.utils.assembler;

import com.ticket.backend.controller.UserController;
import com.ticket.backend.pojo.User;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.server.RepresentationModelAssembler;
import org.springframework.stereotype.Component;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.methodOn;

@Component
public class UserModelAssembler implements RepresentationModelAssembler<User, EntityModel<User>> {

    @Override
    public EntityModel<User> toModel(User user) {
        return EntityModel.of(user,
                linkTo(methodOn(UserController.class).getUser(user.getUserId())).withSelfRel(),
                linkTo(methodOn(UserController.class).getAll()).withRel("users"));
    }
}
