package com.github.kmingulov.log;

import com.github.kmingulov.log.LogServiceProto.LogLevel;
import com.github.kmingulov.log.LogServiceProto.LogMessage;
import com.github.kmingulov.log.service.InMemoryLogService;
import com.github.kmingulov.log.service.LogService;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.protobuf.ProtobufHttpMessageConverter;

@Configuration
public class LogApplicationConfig {

    @Bean
    ProtobufHttpMessageConverter protobufHttpMessageConverter() {
        return new ProtobufHttpMessageConverter();
    }

    @Bean
    LogService logService() {
        LogService logService = new InMemoryLogService();

        logService.save(
                LogMessage.newBuilder()
                        .setLevel(LogLevel.INFO)
                        .setMessage("Hey there!")
                        .build()
        );

        logService.save(
                LogMessage.newBuilder()
                        .setLevel(LogLevel.WARN)
                        .setMessage("Hey there again!")
                        .build()
        );

        return logService;
    }

}
