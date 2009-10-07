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
%wg% http://www.bootzilla.org/5x/mal/VundoFix.exe -P BZ/Malware/
IF %ERRORLEVEL%==1(%log% Backup copy of VundoFix.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/mal/spybotsd162.exe -P BZ/Malware/
IF %ERRORLEVEL%==1(%log% spybotsd162.exe failed to download|%ncr%)
%wg% http://download.bleepingcomputer.com/sUBs/ComboFix.exe -P BZ/Malware/
IF %ERRORLEVEL%==1(%log% ComboFix.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/mal/mssefullinstall-x86fre-en-us-xp.exe -P BZ/Malware/
IF %ERRORLEVEL%==1(%log% mssefullinstall-x86fre-en-us-xp.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/mal/mssefullinstall-x86fre-en-us-vista-win7.exe -P BZ/Malware/
IF %ERRORLEVEL%==1(%log% mssefullinstall-x86fre-en-us-vista-win7.exe failed to download|%ncr%)
:: If NT64=1 checks to see if the user asked for 64-bit apps or not.
:: This reduces the download time and size of files needed.
IF %NT64%==1 %wg% http://www.bootzilla.org/5x/mal/mssefullinstall-amd64fre-en-us-vista-win7.exe -P BZ/Malware/
IF %ERRORLEVEL%==1(%log% mssefullinstall-amd64fre-en-us-vista-win7.exe failed to download|%ncr%)

:end
endlocal
exit