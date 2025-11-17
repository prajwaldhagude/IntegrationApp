# Deployment Guide for Render

## Prerequisites
1. A Render account (sign up at https://render.com)
2. Your code pushed to a Git repository (GitHub, GitLab, or Bitbucket)

## Deployment Steps

### Option 1: Using render.yaml (Recommended)
1. Push your code to GitHub/GitLab/Bitbucket
2. In Render dashboard, click "New" → "Blueprint"
3. Connect your repository
4. Render will automatically detect `render.yaml` and deploy both the web service and RabbitMQ

### Option 2: Manual Setup
1. **Create RabbitMQ Service:**
   - In Render dashboard, click "New" → "RabbitMQ"
   - Name it: `rabbitmq-service`
   - Choose the free plan
   - Note the connection details

2. **Create Web Service:**
   - Click "New" → "Web Service"
   - Connect your repository
   - Configure:
     - **Name:** springboot-task
     - **Environment:** Java
     - **Build Command:** `./mvnw clean package -DskipTests`
     - **Start Command:** `java -jar target/SpringBoot-Task-0.0.1-SNAPSHOT.jar`
     - **Port:** 8080

3. **Add Environment Variables:**
   - `PORT` = `8080`
   - `RABBITMQ_HOST` = (from RabbitMQ service)
   - `RABBITMQ_PORT` = (from RabbitMQ service)
   - `RABBITMQ_USERNAME` = (from RabbitMQ service)
   - `RABBITMQ_PASSWORD` = (from RabbitMQ service)

## Testing After Deployment

Once deployed, you'll get a URL like: `https://your-app-name.onrender.com`

### Quick Test (Browser)
Open: `https://your-app-name.onrender.com/api/v1/publish?message=Hello`

### Using Test Scripts
- **Linux/Mac:** `./test.sh https://your-app-name.onrender.com`
- **Windows PowerShell:** `.\test.ps1 https://your-app-name.onrender.com`

### Using curl
```bash
# Test message endpoint
curl "https://your-app-name.onrender.com/api/v1/publish?message=Test"

# Test event endpoint
curl -X POST https://your-app-name.onrender.com/event \
  -H "Content-Type: application/json" \
  -d '{"site_id":"test","event_type":"page_view","path":"/","user_id":"user1","timestamp":"2024-01-15T10:30:00Z"}'
```

## Troubleshooting

1. **Application won't start:**
   - Check Render logs for errors
   - Verify RabbitMQ service is running
   - Ensure environment variables are set correctly

2. **Connection to RabbitMQ fails:**
   - Verify RabbitMQ service is in the same region
   - Check that all RabbitMQ environment variables are set
   - Review RabbitMQ service logs

3. **Port issues:**
   - Render automatically sets PORT environment variable
   - Application should use `${PORT:8080}` in application.properties (already configured)

## Notes
- Free tier services may spin down after inactivity
- First request after spin-down may take longer
- Check Render dashboard for service status

