package com.ticket.sharingsystem.config;

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
                            "/sharings/",
<<<<<<< Updated upstream
                            "/sharings/{sharingId}",
                            "/comments",
                            "/users/{userId}/sharings"
=======
                            "/sharings/{sharingId}/",
                        "/sharings/{sharingId}/comments/"
>>>>>>> Stashed changes
                ).permitAll()
                .antMatchers(HttpMethod.OPTIONS).permitAll()
                .anyRequest().authenticated();
    }
}
