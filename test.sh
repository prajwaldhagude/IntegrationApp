#!/bin/bash

# Test script for Spring Boot Application on Render
# Replace YOUR_APP_URL with your actual Render app URL

APP_URL="${1:-https://your-app-name.onrender.com}"

echo "Testing Spring Boot Application at: $APP_URL"
echo "=========================================="
echo ""

# Test 1: Simple Message Publishing
echo "Test 1: Publishing a simple message..."
curl -X GET "$APP_URL/api/v1/publish?message=Hello%20from%20test"
echo ""
echo ""

# Test 2: Event Publishing
echo "Test 2: Publishing an event..."
curl -X POST "$APP_URL/event" \
  -H "Content-Type: application/json" \
  -d '{
    "site_id": "test-site-123",
    "event_type": "page_view",
    "path": "/test-page",
    "user_id": "test-user-456",
    "timestamp": "'$(date -u +"%Y-%m-%dT%H:%M:%SZ")'"
  }'
echo ""
echo ""

# Test 3: Another event with different type
echo "Test 3: Publishing a click event..."
curl -X POST "$APP_URL/event" \
  -H "Content-Type: application/json" \
  -d '{
    "site_id": "test-site-123",
    "event_type": "click",
    "path": "/products/item-1",
    "user_id": "test-user-789",
    "timestamp": "'$(date -u +"%Y-%m-%dT%H:%M:%SZ")'"
  }'
echo ""
echo ""

echo "=========================================="
echo "Testing complete!"

