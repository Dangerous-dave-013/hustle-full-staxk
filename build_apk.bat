@echo off
echo ============================================
echo   BUILDING RELEASE APK
echo ============================================
echo.

cd /d "%~dp0"

echo Checking .env file...
if not exist ".env" (
    echo [ERROR] .env file not found!
    echo Please create .env file with your production URL:
    echo API_BASE_URL=https://your-backend-url.onrender.com/api
    pause
    exit /b 1
)

echo [OK] .env file exists
echo.

echo Current API URL:
findstr /C:"API_BASE_URL" .env
echo.
echo Make sure this points to your production backend!
echo If not, edit .env file first.
echo.
pause

echo Cleaning previous build...
flutter clean
echo [OK] Clean complete
echo.

echo Getting dependencies...
flutter pub get
echo [OK] Dependencies fetched
echo.

echo Building release APK...
echo This will take 5-10 minutes...
echo.
flutter build apk --release

if %errorlevel% equ 0 (
    echo.
    echo ============================================
    echo   BUILD SUCCESSFUL!
    echo ============================================
    echo.
    echo Your APK is ready at:
    echo build\app\outputs\flutter-apk\app-release.apk
    echo.
    echo File size: ~50-80 MB
    echo.
    echo Next steps:
    echo 1. Transfer APK to your Android phone
    echo 2. Enable "Install from unknown sources" in phone settings
    echo 3. Install and test the app
    echo.
    echo ============================================
    explorer build\app\outputs\flutter-apk
) else (
    echo.
    echo [ERROR] Build failed!
    echo Check the error messages above.
    echo.
    echo Common fixes:
    echo - Run: flutter doctor
    echo - Update Flutter: flutter upgrade
    echo - Check .env file format
)

echo.
pause
