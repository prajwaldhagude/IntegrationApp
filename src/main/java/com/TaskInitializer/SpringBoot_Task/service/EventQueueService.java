package com.TaskInitializer.SpringBoot_Task.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.TaskInitializer.SpringBoot_Task.dto.EventRequest;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class EventQueueService {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(EventQueueService.class);
    
    @Value("${rabbitmq.exchange.name}")
    private String exchange;
    
    @Value("${rabbitmq.routing.key}")
    private String routingKey;
    
    private final RabbitTemplate rabbitTemplate;
    private final ObjectMapper objectMapper;
    
    public EventQueueService(RabbitTemplate rabbitTemplate, ObjectMapper objectMapper) {
        this.rabbitTemplate = rabbitTemplate;
        this.objectMapper = objectMapper;
    }
    
    public void sendEvent(EventRequest event) {
        try {
            String eventJson = objectMapper.writeValueAsString(event);
            LOGGER.info("Sending event to RabbitMQ: {}", eventJson);
            rabbitTemplate.convertAndSend(exchange, routingKey, eventJson);
            LOGGER.info("Event sent successfully to RabbitMQ");
        } catch (JsonProcessingException e) {
            LOGGER.error("Error converting event to JSON: {}", e.getMessage());
            throw new RuntimeException("Failed to serialize event", e);
        }
    }
}

