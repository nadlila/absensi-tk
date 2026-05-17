package com.absensi_api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
 
@SpringBootApplication
@EnableScheduling
public class AbsensiApiApplication { 

	public static void main(String[] args) {
		SpringApplication.run(AbsensiApiApplication.class, args);
	}

}
