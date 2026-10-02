@echo off
chcp 65001 >nul
setlocal
rem สร้างโปรแกรมติดตั้ง.bat — double-click launcher that builds the
rem "ปราณปรียา แอดมิน" desktop installer on this computer. Avoids
rem PowerShell entirely (no execution-policy prompts, no && issues), and
rem always runs from the folder this .bat file is in.

cd /d "%~dp0"

where node >nul 2>nul
if errorlevel 1 goto :no_node

if exist "node_modules" goto :build

echo กำลังติดตั้งไลบรารีที่จำเป็น ครั้งแรกอาจใช้เวลาสักครู่...
echo.
call npm install
if errorlevel 1 goto :install_failed

:build
echo.
echo กำลังสร้างโปรแกรมติดตั้ง (อาจใช้เวลาหลายนาทีในครั้งแรก)...
echo.
call npm run dist
if errorlevel 1 goto :dist_failed

echo.
echo เสร็จแล้ว! ไฟล์ติดตั้งอยู่ในโฟลเดอร์ dist-installer
echo กำลังเปิดโฟลเดอร์ให้...
start "" "%~dp0dist-installer"

echo.
pause
exit /b 0

:no_node
echo ไม่พบ Node.js บนเครื่องนี้
echo กรุณาติดตั้ง Node.js จาก https://nodejs.org ก่อน แล้วลองใหม่อีกครั้ง
echo.
pause
exit /b 1

:install_failed
echo.
echo ติดตั้งไลบรารีไม่สำเร็จ ดูรายละเอียด error ด้านบน
echo.
pause
exit /b 1

:dist_failed
echo.
echo สร้างโปรแกรมติดตั้งไม่สำเร็จ ดูรายละเอียด error ด้านบน
echo.
pause
exit /b 1
