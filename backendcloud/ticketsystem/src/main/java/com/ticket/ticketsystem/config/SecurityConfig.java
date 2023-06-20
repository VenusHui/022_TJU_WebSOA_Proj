package com.ticket.ticketsystem.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;

/**
 * @author: VenusHui
 * @description: TODO
 * @date: 2022/12/20 15:18
 * @version: 1.0
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable()
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .authorizeRequests()
                .antMatchers(
                        "/users/{userId}/orders/",
                        "/users/{userId}/orders/{orderId}/tickets/",
                        "/users/{userId}/tickets/{ticketId}/",
                        "/users/{userId}/validTicket/",
                        "/users/{userId}/orders/{orderId}/",
                        "/shows/{showId}/",
                        "/users/{userId}/ticket_stall/{ticketStallId}/",
                        "/shows/{showId}/",
                        "/shows/",
                        "/shows1/",
                        "/shows2/",
                        "/search/",
                        "/users/{userId}/tickets/{ticketId}/resale/",
                        "/histrionics/{histrionicsId}/ticket_stall/",
                        "/shows/{showId}/resale/",
                        "/users/{userId}/resale/",
                        "/users/{userId}/resales/{resaleId}/",
                        "/histrionics/{histrionicsId}/show/",
                        "/locations/",
                        "/locations/{locationId}/",
                        "/users/{userId}/tickets/{ticketId}/",
                        "/locations/{locationId}/shows/",
                        "/histrionics/{histrionicsId}/location/",
                        "/histrionics/"
                ).permitAll()
                .antMatchers(HttpMethod.OPTIONS).permitAll()
                .anyRequest().authenticated();
    }
}
