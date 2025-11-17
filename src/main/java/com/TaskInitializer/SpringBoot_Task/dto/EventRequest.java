package com.TaskInitializer.SpringBoot_Task.dto;

import lombok.Data;

@Data
public class EventRequest {
    private String site_id;
    private String event_type;
    private String path;
    private String user_id;
    private String timestamp;
}
