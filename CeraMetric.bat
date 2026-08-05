@echo off
chcp 65001 >nul
title CeraMetric
cd /d "%~dp0"

if not exist "index.html" (
  echo.
  echo   ERROR: no encuentro index.html
  echo.
  echo   Este archivo .bat tiene que estar en la misma carpeta que index.html.
  echo   Si descomprimiste el ZIP, abrí la carpeta que quedó adentro.
  echo.
  pause
  exit /b 1
)

if not exist "xlsx.full.min.js" (
  echo.
  echo   AVISO: falta xlsx.full.min.js en esta carpeta.
  echo   La exportación a Excel no va a funcionar. CSV y JSON sí.
  echo.
  timeout /t 4 >nul
)

echo.
echo   Abriendo CeraMetric en el navegador...
echo   Podés cerrar esta ventana.
echo.
start "" "%~dp0index.html"
exit /b 0
