@echo off
:: Check for admin rights and elevate if needed
NET SESSION >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

echo Running with administrative privileges
echo Searching for USB Serial Converter devices...

:: Create a temporary file for storing usbipd output
set "tempfile=%temp%\usbipd_list.txt"
usbipd list > "%tempfile%"

:: Search for devices with "USB Serial Converter A" or "USB Serial Converter B"
findstr /C:"USB Serial Converter A" /C:"USB Serial Converter B" "%tempfile%" > "%temp%\converter_devices.txt"

:: Check if any matching devices were found
set "found_devices=0"
for /f "tokens=1" %%i in ('findstr /R "^[0-9]-[0-9]" "%temp%\converter_devices.txt"') do (
    echo Found device with BUSID: %%i
    call :process_device %%i
    set "found_devices=1"
)

if "%found_devices%"=="0" (
    echo No USB Serial Converter devices found.
)

:: Clean up temporary files
del "%tempfile%" 2>nul
del "%temp%\converter_devices.txt" 2>nul

echo All matching devices have been processed.
echo Press any key to exit...
pause >nul
exit /b

:process_device
echo Processing device with BUSID: %1
echo Binding device %1...
usbipd bind --busid %1
if %errorLevel% neq 0 (
    echo Failed to bind device %1.
) else (
    echo Attaching device %1 to WSL...
    usbipd attach --busid %1 --wsl
    if %errorLevel% neq 0 (
        echo Failed to attach device %1 to WSL.
    ) else (
        echo Successfully attached device %1 to WSL!
    )
)
goto :eof
