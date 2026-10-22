@echo off
setlocal
for %%P in (DigUp.exe DigUp-IME-test.exe) do (
  tasklist /FI "IMAGENAME eq %%P" /NH 2>nul | find /I "%%P" >nul
  if not errorlevel 1 (
    echo Please quit DigUp from its tray menu before starting this test build.
    pause
    exit /b 1
  )
)
set "IME_TEST_DATA=%LOCALAPPDATA%\DigUp-IME-Test"
if not exist "%IME_TEST_DATA%" mkdir "%IME_TEST_DATA%"
if not exist "%IME_TEST_DATA%\settings.json" (
  >"%IME_TEST_DATA%\settings.json" echo {"setUp":true,"updateChecksOff":true,"processorOnly":true}
)
start "" /D "%~dp0" "%~dp0DigUp-IME-test.exe" --index "%IME_TEST_DATA%\index" --settings "%IME_TEST_DATA%\settings.json" --models "%LOCALAPPDATA%\DigUp\Models" --roots "%~dp0TestFiles" --hotkey "Ctrl+Alt+Shift+D"
