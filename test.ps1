# PowerShell test script for Spring Boot Application on Render
# Usage: .\test.ps1 [APP_URL]
# Example: .\test.ps1 https://your-app-name.onrender.com

param(
    [string]$AppUrl = "https://your-app-name.onrender.com"
)

Write-Host "Testing Spring Boot Application at: $AppUrl" -ForegroundColor Cyan
Write-Host "=========================================="
Write-Host ""

# Test 1: Simple Message Publishing
Write-Host "Test 1: Publishing a simple message..." -ForegroundColor Yellow
$response1 = Invoke-WebRequest -Uri "$AppUrl/api/v1/publish?message=Hello%20from%20test" -Method GET
Write-Host $response1.Content
Write-Host ""

# Test 2: Event Publishing
Write-Host "Test 2: Publishing an event..." -ForegroundColor Yellow
$eventBody = @{
    site_id = "test-site-123"
    event_type = "page_view"
    path = "/test-page"
    user_id = "test-user-456"
    timestamp = (Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ")
} | ConvertTo-Json

$response2 = Invoke-WebRequest -Uri "$AppUrl/event" -Method POST -Body $eventBody -ContentType "application/json"
Write-Host $response2.Content
Write-Host ""

# Test 3: Another event with different type
Write-Host "Test 3: Publishing a click event..." -ForegroundColor Yellow
$clickEventBody = @{
    site_id = "test-site-123"
    event_type = "click"
    path = "/products/item-1"
    user_id = "test-user-789"
    timestamp = (Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ")
} | ConvertTo-Json

$response3 = Invoke-WebRequest -Uri "$AppUrl/event" -Method POST -Body $clickEventBody -ContentType "application/json"
Write-Host $response3.Content
Write-Host ""

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Testing complete!" -ForegroundColor Green

