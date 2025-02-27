@echo off
:: Check/Request Admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting admin privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c %~f0' -Verb RunAs"
    exit /b
)

:: Restart Audio Services
net stop audiosrv
net stop AudioEndpointBuilder
net start AudioEndpointBuilder
net start audiosrv

:: Countdown
setlocal enabledelayedexpansion
for /l %%i in (5,-1,1) do (
    <nul set /p "=Audio restarted. Auto-closing in %%i seconds...    " 
    timeout /t 1 >nul
    <nul set /p "=[G"
)
exit
