# ============================================
# Hustle App - Setup Script
# ============================================

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "    Hustle App - Backend Setup      " -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Check if Node.js is installed
Write-Host "[1/6] Checking Node.js installation..." -ForegroundColor Yellow
try {
    $nodeVersion = node --version
    Write-Host "✓ Node.js is installed: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Node.js is not installed!" -ForegroundColor Red
    Write-Host "Please install Node.js from https://nodejs.org/" -ForegroundColor Red
    exit 1
}

# Check if MongoDB is running
Write-Host ""
Write-Host "[2/6] Checking MongoDB..." -ForegroundColor Yellow
$mongoService = Get-Service -Name MongoDB -ErrorAction SilentlyContinue
if ($mongoService -and $mongoService.Status -eq 'Running') {
    Write-Host "✓ MongoDB is running" -ForegroundColor Green
} else {
    Write-Host "⚠ MongoDB is not running. Attempting to start..." -ForegroundColor Yellow
    try {
        Start-Service -Name MongoDB
        Write-Host "✓ MongoDB started successfully" -ForegroundColor Green
    } catch {
        Write-Host "✗ Could not start MongoDB. Please install from https://www.mongodb.com/try/download/community" -ForegroundColor Red
        Write-Host "Or start it manually: net start MongoDB" -ForegroundColor Yellow
    }
}

# Navigate to backend directory
Write-Host ""
Write-Host "[3/6] Installing backend dependencies..." -ForegroundColor Yellow
Set-Location -Path "backend"

if (Test-Path "node_modules") {
    Write-Host "⚠ node_modules already exists. Skipping npm install." -ForegroundColor Yellow
} else {
    npm install
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Backend dependencies installed" -ForegroundColor Green
    } else {
        Write-Host "✗ Failed to install dependencies" -ForegroundColor Red
        exit 1
    }
}

# Check if .env exists
Write-Host ""
Write-Host "[4/6] Checking environment configuration..." -ForegroundColor Yellow
if (Test-Path ".env") {
    Write-Host "✓ Backend .env file exists" -ForegroundColor Green
} else {
    Write-Host "⚠ Creating .env file..." -ForegroundColor Yellow
    $envContent = @"
PORT=3000
MONGODB_URI=mongodb://localhost:27017/hustle
JWT_SECRET=hustle_secret_key_change_in_production_$(Get-Random)
STRIPE_SECRET_KEY=sk_test_your_stripe_secret_key_here
"@
    Set-Content -Path ".env" -Value $envContent
    Write-Host "✓ Created .env file. Please update with your Stripe key!" -ForegroundColor Green
}

# Seed database
Write-Host ""
Write-Host "[5/6] Seeding database with sample data..." -ForegroundColor Yellow
$choice = Read-Host "Do you want to seed the database? (y/n)"
if ($choice -eq 'y' -or $choice -eq 'Y') {
    node seed.js
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Database seeded successfully" -ForegroundColor Green
    } else {
        Write-Host "⚠ Database seeding failed. You can run 'node seed.js' manually later." -ForegroundColor Yellow
    }
}

# Start server
Write-Host ""
Write-Host "[6/6] Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "         Setup Complete!             " -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Update backend/.env with your Stripe secret key" -ForegroundColor White
Write-Host "2. Run 'npm start' to start the backend server" -ForegroundColor White
Write-Host "3. Set up Flutter app (see QUICK_START.md)" -ForegroundColor White
Write-Host ""
Write-Host "Test Credentials:" -ForegroundColor Cyan
Write-Host "  Email: test@example.com" -ForegroundColor White
Write-Host "  Password: password123" -ForegroundColor White
Write-Host ""

$startServer = Read-Host "Do you want to start the backend server now? (y/n)"
if ($startServer -eq 'y' -or $startServer -eq 'Y') {
    Write-Host ""
    Write-Host "Starting backend server..." -ForegroundColor Green
    npm start
}
