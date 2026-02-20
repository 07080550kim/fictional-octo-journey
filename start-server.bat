@echo off
chcp 65001 >nul
title TeleAI Server
color 0A

echo.
echo  =======================================
echo   TeleAI Server
echo  =======================================
echo.

cd /d "%~dp0"

:: Проверка Node.js
where node >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo  [ERROR] Node.js not found!
    echo  Please install it from: https://nodejs.org
    pause
    exit /b 1
)

:: Проверка модулей
if not exist "node_modules" (
    echo  [*] First run detected. Installing dependencies...
    call npm install
)

:: Проверка БД
if not exist "packages\server\data\teleai.db" (
    echo  [*] Setting up database...
    call npm run db:push
    call npm run db:seed
)

echo.
echo  [*] Starting TeleAI Server...
echo  [*] Press Ctrl+C to stop.
echo.

:: Запуск
npm run start

pause
