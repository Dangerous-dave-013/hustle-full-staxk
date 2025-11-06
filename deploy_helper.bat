@echo off
echo ============================================
echo   HUSTLE APP - DEPLOYMENT HELPER
echo ============================================
echo.

echo Step 1: Checking Git installation...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Git is not installed!
    echo Please download from: https://git-scm.com/download/win
    echo Or use GitHub Desktop: https://desktop.github.com/
    pause
    exit /b 1
)
echo [OK] Git is installed
echo.

echo Step 2: Initializing Git repository...
cd /d "%~dp0backend"
if not exist ".git" (
    git init
    echo [OK] Git repository initialized
) else (
    echo [OK] Git repository already exists
)
echo.

echo Step 3: Creating .gitignore if needed...
if not exist ".gitignore" (
    echo node_modules/ > .gitignore
    echo .env >> .gitignore
    echo logs/ >> .gitignore
    echo *.log >> .gitignore
    echo [OK] .gitignore created
) else (
    echo [OK] .gitignore already exists
)
echo.

echo Step 4: Adding files to Git...
git add .
git commit -m "Hustle backend with fake payment gateway - Ready for deployment"
echo [OK] Files committed
echo.

echo ============================================
echo   NEXT STEPS:
echo ============================================
echo.
echo 1. Create GitHub repository:
echo    https://github.com/new
echo    Name: hustle-backend
echo.
echo 2. Push your code:
echo    git remote add origin https://github.com/YOUR_USERNAME/hustle-backend.git
echo    git branch -M main
echo    git push -u origin main
echo.
echo 3. Deploy to Render:
echo    https://render.com/
echo    - Sign up with GitHub
echo    - New + Web Service
echo    - Connect hustle-backend repo
echo    - Add environment variables
echo.
echo 4. Update .env with production URL
echo.
echo 5. Build APK:
echo    flutter build apk --release
echo.
echo ============================================
echo See DEPLOYMENT_GUIDE.md for detailed steps!
echo ============================================
pause
