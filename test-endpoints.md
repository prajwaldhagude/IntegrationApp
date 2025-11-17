# Testing Your Spring Boot Application on Render

## Prerequisites
After deploying to Render, you'll get a URL like: `https://your-app-name.onrender.com`

## Available Endpoints

### 1. Test Message Publishing (GET)
Send a simple message to RabbitMQ queue.

**Endpoint:** `GET /api/v1/publish`

**Example:**
```bash
curl "https://your-app-name.onrender.com/api/v1/publish?message=Hello%20World"
```

**Expected Response:**
```
Message send to RabbitMQ...
```

### 2. Test Event Publishing (POST)
Send a structured event to RabbitMQ queue.

**Endpoint:** `POST /event`

**Example:**
```bash
curl -X POST https://your-app-name.onrender.com/event \
  -H "Content-Type: application/json" \
  -d '{
    "site_id": "site123",
    "event_type": "page_view",
    "path": "/home",
    "user_id": "user456",
    "timestamp": "2024-01-15T10:30:00Z"
  }'
```

**Expected Response:**
```
Event Received
```

## Testing with Postman

### Test 1: Simple Message
1. Method: GET
2. URL: `https://your-app-name.onrender.com/api/v1/publish?message=TestMessage`
3. Send request

### Test 2: Event
1. Method: POST
2. URL: `https://your-app-name.onrender.com/event`
3. Headers: `Content-Type: application/json`
4. Body (raw JSON):
```json
{
  "site_id": "site123",
  "event_type": "click",
  "path": "/products",
  "user_id": "user789",
  "timestamp": "2024-01-15T10:30:00Z"
}
```

## Testing with Browser
Simply open:
```
https://your-app-name.onrender.com/api/v1/publish?message=Hello
```

## Health Check
You can also check if the app is running by accessing the root endpoint (if configured) or the publish endpoint.

## Notes
- Make sure your RabbitMQ service is running on Render
- Check Render logs if endpoints don't respond
- The application will automatically connect to the RabbitMQ service configured in Render

