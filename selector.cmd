@echo off
color F1
set _cd=%cd%
set _task=
if exist %systemroot%\cygwin1.dll del %systemroot%\cygwin1.dll&&echo .&&echo Removed old cygwin1.dll file.
if not exist %systemroot%\cygwin1.dll copy %_cd%\cygwin1.dll %systemroot%\cygwin1.dll&&echo .&&echo Copied cygwin1.dll to %systemroot%
cls
echo.
echo *****************************
echo * Testdisk Program Selector *
echo * v1.70                     *
echo * bootzilla.org             *
echo *****************************
echo For Testdisk v6.x
echo.
echo [1] Testdisk
echo [2] Photo Recovery
echo.
echo                              Press ENTER to Exit
echo.
set /p _task=Please enter the number of the program you wish to run:  


if "%_task%" == "" goto end
if "%_task%" == "1" goto td
if "%_task%" == "2" goto pr

echo.
echo You have selected %_task%. Now Launching...

:td
:: Launches testdisk_win.exe
cmd.exe /c testdisk_win.exe
goto end

:pr
:: Launches photorec_win.exe
cmd.exe /c photorec_win.exe
goto end

:end

