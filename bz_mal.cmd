@echo off
cls
setlocal
color F1
:: bz_mal.cmd
:: Downloads the latest anti-malware utilities from the bootzilla server.
set _retries=3
set wg=wget -N -t %_retries%
echo.
%wg% http://www2.gmer.net/gmer.zip -P BZ/Malware/
IF %ERRORLEVEL%==1(%log% gmer.zip failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/mal/HijackThis2_sfx.exe -P BZ/Malware/
IF %ERRORLEVEL%==1(%log% HijackThis2_sfx.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/mal/SpybotSD_SFX.exe -P BZ/Malware/
IF %ERRORLEVEL%==1(%log% SpybotSD_SFX.exe failed to download|%ncr%)
%wg% http://www.atribune.org/ccount/click.php?id=4 -P BZ/Malware/
IF %ERRORLEVEL%==1(%log% VundoFix.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/mal/SmitfraudfixSFX.exe -P BZ/Malware/
IF %ERRORLEVEL%==1(%log% SmitFraudfixSFX.exe failed to download|%ncr%)
%wg% http://www.jayloden.com/aimfix.exe -P BZ/Malware/
IF %ERRORLEVEL%==1(%log% aimfix.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/mal/mbam-setup.exe -P BZ/Malware/
IF %ERRORLEVEL%==1(%log% mbam-setup.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/mal/mbam-rules.exe -P BZ/Malware/
IF %ERRORLEVEL%==1(%log% mbam-rules.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/mal/VundoFix.exe -P BZ/Malware/
IF %ERRORLEVEL%==1(%log% Backup copy of VundoFix.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/mal/spybotsd162.exe -P BZ/Malware/
IF %ERRORLEVEL%==1(%log% spybotsd162.exe failed to download|%ncr%)
%wg% http://download.bleepingcomputer.com/sUBs/ComboFix.exe -P BZ/Malware/
IF %ERRORLEVEL%==1(%log% ComboFix.exe failed to download|%ncr%)
:: If NT64=1 only get the x64 version, which is at the same url, except it is _nt64_, not _nt32_.
%wg% http://www.bootzilla.org/5x/mal/eav_nt32_enu.msi -P BZ/Malware/
if %NT64%==1 %wg% http://www.bootzilla.org/5x/mal/eav_nt64_enu.msi -P BZ/Malware/
IF %ERRORLEVEL%==1(%log% eav_nt64_enu.msi failed to download|%ncr%)
:end
endlocal
exit