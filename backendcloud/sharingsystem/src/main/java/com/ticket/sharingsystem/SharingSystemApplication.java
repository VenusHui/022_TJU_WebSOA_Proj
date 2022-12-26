package com.ticket.sharingsystem;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class SharingSystemApplication {
    public static void main(String[] args) {
        SpringApplication.run(SharingSystemApplication.class, args);
    }
}