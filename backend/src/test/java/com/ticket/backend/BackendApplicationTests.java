package com.ticket.backend;

import com.ticket.backend.mapper.UserMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootTest
class BackendApplicationTests {
	@Autowired
	private UserMapper userMapper;

	@Test
	void contextLoads() {
		System.out.println(userMapper.selectList(null));
	}

}
