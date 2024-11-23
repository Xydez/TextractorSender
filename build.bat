@ECHO OFF

rmdir /s /q build
mkdir build

echo ===== GENERATING PROJECT =====
cmake --preset=x86-windows-static || goto :error

echo ===== BUILDING PROJECT =====
cmake --build build --config Release || goto :error

goto :end

:error
echo Failed with error %errorlevel%
REM exit /b %errorlevel%

:end
pause
