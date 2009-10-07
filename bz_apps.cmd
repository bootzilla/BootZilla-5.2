@echo off
cls
setlocal
color F1
:: bz_apps.cmd
:: Downloads the latest apps from the BootZilla server.
:: Set WGET Retries.
set _retries=3
:: This actually sets up the wg constant/variable below.
set wg=wget -N -t %_retries%
::
echo.
%wg% http://www.bootzilla.org/5x/apps/7z465.exe -P BZ/Apps
IF %ERRORLEVEL%==1(%log% 7z465.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/apps/VCR446.exe -P BZ/Apps
IF %ERRORLEVEL%==1(%log% VCR446.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/apps/msicuu2.exe -P BZ/Apps
IF %ERRORLEVEL%==1(%log% msicuu2.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/apps/utorrent.exe -P BZ/Apps
IF %ERRORLEVEL%==1(%log% utorrent.exe failed to download|%ncr%)
:end
endlocal
exit