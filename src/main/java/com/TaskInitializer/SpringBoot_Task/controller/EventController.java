package com.TaskInitializer.SpringBoot_Task.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.TaskInitializer.SpringBoot_Task.dto.EventRequest;
import com.TaskInitializer.SpringBoot_Task.service.EventQueueService;

@RestController
public class EventController {

    @Autowired
    private EventQueueService queueService;

    @PostMapping("/event")
    public ResponseEntity<String> receiveEvent(@RequestBody EventRequest request) {
        queueService.sendEvent(request);
        return ResponseEntity.ok("Event Received");
    }
}

