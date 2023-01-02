package com.ticket.ticketsystem.service;

import java.util.Map;

public interface LocationService {
    public Map<String,Object> getAllLocations();
    public Map<String,Object> getLocationsByLocationId(Integer locationId);
}
