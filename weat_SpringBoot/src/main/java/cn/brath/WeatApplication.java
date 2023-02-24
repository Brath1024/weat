package cn.brath;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@MapperScan(basePackages = {"cn.brath.mapper", "cn.brath.config"})
@Slf4j
public class WeatApplication {

    public static void main(String[] args) {
        SpringApplication.run(WeatApplication.class, args);
    }

}
