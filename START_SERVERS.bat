@echo off
REM Quick Start Script for EduPlatform
REM Run this file to start both servers automatically

echo.
echo ╔════════════════════════════════════════╗
echo ║    EduPlatform - Quick Start           ║
echo ╚════════════════════════════════════════╝
echo.

REM Check if Node.js is installed
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Node.js is not installed!
    echo Please download from: https://nodejs.org
    pause
    exit /b 1
)

echo ✓ Node.js found
echo.

REM Check if dependencies are installed
if not exist "node_modules" (
    echo Installing frontend dependencies...
    call npm install
    echo.
)

if not exist "server\node_modules" (
    echo Installing server dependencies...
    cd server
    call npm install
    cd ..
    echo.
)

echo.
echo ╔════════════════════════════════════════╗
echo ║  Starting EduPlatform Servers   
      ║
echo ╚════════════════════════════════════════╝
echo.

REM Start backend in new window
echo Starting Backend Server...
start cmd /k "cd server && npm start"

REM Wait a moment for backend to start
timeout /t 2 /nobreak

REM Start frontend in new window
echo Starting Frontend Server...
start cmd /k "npm run dev"

echo.
echo ✓ Both servers started!
echo.
echo Access the application at:
echo   Frontend: http://localhost:5173
echo   Backend:  http://localhost:5000/api/health
echo.
echo Press Ctrl+C in each terminal to stop the servers
echo.
pause
