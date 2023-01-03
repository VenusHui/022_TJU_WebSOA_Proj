package com.ticket.ticketsystem.controller;

import com.ticket.ticketsystem.service.LocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LocationController {
    @Autowired
    LocationService locationService;

    @GetMapping("/locations/")
    public ResponseEntity<Object> getAll(){
        return ResponseEntity.ok(locationService.getAllLocations());
    }

    @GetMapping("/locations/{locationId}/")
    public ResponseEntity<Object> getLocation(@PathVariable Integer locationId){
        return ResponseEntity.ok(locationService.getLocationsByLocationId(locationId));
    }

    @GetMapping("/locations/{locationId}/shows/")
    public ResponseEntity<Object> getShowsInfo(@PathVariable Integer locationId){
        return ResponseEntity.ok(locationService.getShowsInfoByLocationId(locationId));
    }
}
