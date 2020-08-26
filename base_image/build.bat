@setlocal
@echo off

cd %~d0
docker build -t nupan/factorio-server-base .
if errorlevel 1 (
    exit /b %errorlevel%
)

exit /b 0
