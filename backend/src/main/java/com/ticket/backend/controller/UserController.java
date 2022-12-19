package com.ticket.backend.controller;

import com.ticket.backend.assembler.UserModelAssembler;
import com.ticket.backend.mapper.UserMapper;
import com.ticket.backend.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.methodOn;

@RestController
public class UserController {

    @Autowired
    UserMapper userMapper;

    private final UserModelAssembler assembler;

    public UserController(UserModelAssembler assembler) {
        this.assembler = assembler;
    }

    @RequestMapping("/users/")
    public CollectionModel<EntityModel<User>> getAll() {
        List<EntityModel<User>> users = userMapper.selectList(null).stream()
                .map(assembler::toModel)
                .collect(Collectors.toList());
        return CollectionModel.of(users, linkTo(methodOn(UserController.class).getAll()).withSelfRel());
    }

    @RequestMapping("/users/{userId}/")
    public EntityModel<User> getUser(@PathVariable Integer userId) {
        User user = userMapper.selectById(userId);
        return assembler.toModel(user);
    }
}
