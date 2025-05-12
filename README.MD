# USB Serial Converter Attachment Tool for WSL

This utility automatically detects USB Serial Converter devices and attaches them to Windows Subsystem for Linux (WSL).

## Features

- Automatically runs with administrative privileges
- Detects USB Serial Converter A and USB Serial Converter B devices (FTDI)
- Binds detected devices to usbipd
- Attaches devices to WSL
- Provides clear feedback about the process
- Handles cases when no compatible devices are connected

## Requirements

- Windows 10/11 with WSL installed
- [USBIPD-WIN](https://github.com/dorssel/usbipd-win) installed on the Windows host
- USB-IP support configured in your WSL distribution

## Usage

1. Connect your USB Serial Converter device(s) to your Windows machine
2. Double-click `usbpid_attach_wsl.bat` or `usbpid_attach_wsl.exe`
3. If prompted, allow the script to run with administrative privileges
4. The script will automatically:
   - Find compatible USB Serial Converter devices
   - Bind them to the USBIPD service
   - Attach them to your WSL instance