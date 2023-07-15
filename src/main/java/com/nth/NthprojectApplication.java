package com.nth;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.nth.mapper")
public class NthprojectApplication {

    public static void main(String[] args) {
        SpringApplication.run(NthprojectApplication.class, args);
    }

}
