package com.ticket.ticketsystem.controller;

import com.ticket.ticketsystem.service.CategoriesShowsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CategoriesShowsController {
    @Autowired
    CategoriesShowsService categoriesShowsService;

    @GetMapping("/shows")
    public ResponseEntity<Object> getShowDetailByCategories(String categories){
        return ResponseEntity.ok(categoriesShowsService.getShowDetailByCategories(categories));
    }

}
