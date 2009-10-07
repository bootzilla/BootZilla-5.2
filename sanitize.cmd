@echo off
setlocal
color F1
set BZ="BZ"
set u="BZ\Utils"
set m="BZ\Malware"
set a="BZ\Apps"
set cgt="CGT"
:: set logger path
set log=logger.exe
set ncr=nocrlf.exe
:: set logfile to the entered value, set format to <date> <time>: <message>LINEFEED
set LOGGER_OPTS="logfile=bzlog.log;FORMAT=" $M$_""
cls
echo.
echo ***********************
echo  BootZilla Sanitize
echo  Version 5.2
echo  www.bootzilla.org   
echo *********************** 
echo.
%log% Sanitize.cmd removed^:|%ncr%
echo.
ECHO Now cleaning files from previous patches...
echo.

:: old sanitize script follows...
::
ECHO Now cleaning temporary files...
if exist %u%\SysinternalsSuite.zip del %u%\SysinternalsSuite.zip&&%log% SysinternalsSuite.zip|%ncr%
if exist %u%\UKD_14-20_Beta.zip del %u%\UKD_14-20_Beta.zip&&%log% UKD_14-20_Beta.zip|%ncr%
if exist %u%\daf.zip del %u%\daf.zip&&%log% daf.zip|%ncr%
if exist %u%\unstopcp.zip del %u%\unstopcp.zip&&%log% unstopcp.zip|%ncr%
if exist %u%\hoster.zip del %u%\hoster.zip&&%log% hoster.zip|%ncr%
if exist %u%\UDPixel21_en.zip del %u%\UDPixel21_en.zip&&%log% UDPixel21_en.zip|%ncr%
if exist %u%\adsspy.zip del %u%\adsspy.zip&&%log% adsspy.zip|%ncr%
if exist %u%\cpu-z-140.zip del %u%\cpu-z-140.zip&&%log% cpu-z-140.zip|%ncr%
if exist %u%\startuplist.zip del %u%\startuplist.zip&&%log% startuplist.zip|%ncr%
if exist %u%\autobackup.exe del %u%\autobackup.exe&&%log% autobackup.exe|%ncr%
if exist %a%\autobackup-win.exe del %a%\autobackup-win.exe&&%log% autobackup-win.exe|%ncr%
if exist %m%\gmer.zip del %m%\gmer.zip&&%log% gmer.zip|%ncr%
if exist %u%\lspfix.zip del %u%\lspfix.zip&&%log% lspfix.zip|%ncr%
if exist %u%\KeyfinderThingLite.zip del %u%\KeyfinderThingLite.zip&&%log% KeyfinderThingLite.zip|%ncr%
if exist %u%\Readme.txt del %u%\Readme.txt&&%log% Readme.txt|%ncr%
if exist %a%\HostsXpert.zip del %a%\HostsXpert.zip&&%log% HostsXpert.zip|%ncr%
if exist %u%\viewpointkiller.zip del %u%\viewpointkiller.zip&&%log% viewpointkiller.zip|%ncr%
if exist %m%\AboutBuster.zip del %m%\AboutBuster.zip&&%log% AboutBuster.zip|%ncr%
if exist %m%\SmitfraudFix.zip del %m%\SmitfraudFix.zip&&%log% SmitfraudFix.zip|%ncr%
::
if exist %u%\openwithview.zip del %u%\openwithview.zip&&%log% openwithview.zip|%ncr%
if exist "%a%\Aim Ad Hack 5.52.exe" del "%a%\Aim Ad Hack 5.52.exe"&&%log% Aim Ad Hack 5.52.exe|%ncr%
if exist %a%\unlocker1.8.5.exe del %a%\unlocker1.8.5.exe&&%log% unlocker1.8.5.exe|%ncr%
if exist %a%\klcodec375c.exe del %a%\klcodec375c.exe&&%log% klcodec375c.exe|%ncr%
if exist %u%\appwizXP.7z del %u%\appwizXP.7z&&%log% appwizXP.7z|%ncr%
if exist %u%\gmer.zip del %u%\gmer.zip&&%log% gmer.zip|%ncr%
::
if exist %u%\wul.zip del %u%\wul.zip&&%log% wul.zip|%ncr%
if exist %u%\dialupass2.zip del %u%\dialupass2.zip&&%log% dialupass2.zip|%ncr%
if exist %u%\netpass.zip del %u%\netpass.zip&&%log% netpass.zip|%ncr%
if exist %u%\axhelper.zip del %u%\axhelper.zip&&%log% axhelper.zip|%ncr%
if exist %u%\shexview.zip del %u%\shexview.zip&&%log% shexview.zip|%ncr%
if exist %u%\myuninst.zip del %u%\myuninst.zip&&%log% myuninst.zip|%ncr%
if exist %a%\XP_Codec_Pack_2.3.6.exe del %a%\XP_Codec_Pack_2.3.6.exe&&%log% XP_Codec_Pack_2.3.6.exe|%ncr%
if exist %a%\jre165.exe del %a%\jre165.exe&&%log% jre165.exe|%ncr%
::  New Cleaning script follows
if exist %u%\PureRa13Binary.zip del %u%\PureRa13Binary.zip&&%log% PureRa13Binary.zip|%ncr%
if exist %u%\PureRa14binary.zip del %u%\PureRa14binary.zip&&%log% PureRa14binary.zip|%ncr%
if exist %u%\JavaRa.zip del %u%\JavaRa.zip&&%log% JavaRa.zip|%ncr%
if exist %u%\cpuz_150.zip del %u%\cpuz_150.zip&&%log% cpuz_150.zip|%ncr%
if exist %u%\cpuz_152.zip del %u%\cpuz_152.zip&&%log% cpuz_152.zip|%ncr%
if exist %u%\regscanner.zip del %u%\regscanner.zip&&%log% regscanner.zip|%ncr%
if exist %u%\erunt.zip del %u%\erunt.zip&&%log% erunt.zip|%ncr%
if exist %u%\keyfinder.2.0.6.zip del %u%\keyfinder.2.0.6.zip&&%log% keyfinder.2.0.6.zip|%ncr%
if exist %u%\ViewPointKiller\*.* del /F /S /Q %u%\ViewPointKiller\&&rmdir %u%\ViewPointKiller
:: if exist %BZ%\autorun.inf del %BZ%\autorun.inf&&%log% autorun.inf|%ncr%
if exist %cgt%\*.* del /F /S /Q %cgt%\
:: Finish sanitizing the toolkit
if exist malware.urls del *.urls&%log% Old URLS deleted|%ncr%
echo Copying Info Files...
if exist BZ\Utils\RegScanner\*.* del BZ\Utils\RegScanner\*.* && RMDIR BZ\Utils\RegScanner
if exist BZ\readme.txt del BZ\readme.txt&&%log% readme.txt deleted|%ncr%
if exist BZ\changelog.txt del BZ\changelog.txt&&%log% changelog.txt deleted|%ncr%
if exist BZ\index.html del BZ\index.html&&%log% index.html deleted|%ncr%
if exist BZ\bzstyles.css del BZ\bzstyles.css&&%log% bzstyles.css deleted|%ncr%
if exist BZ\autorun.inf del BZ\autorun.inf&&%log% autorun.inf deleted|%ncr%
if not exist BZ\readme.txt copy readme.txt BZ&&%log% readme.txt copied|%ncr%
if not exist BZ\changelog.txt copy changelog.txt BZ&&%log% changelog.txt copied|%ncr%
if not exist BZ\index.html copy index.html BZ&&%log% index.html copied|%ncr%
if not exist BZ\bzstyles.css copy bzstyles.css BZ&&%log% bzstyles.css copied|%ncr%
if not exist BZ\autorun.inf copy autorun.inf BZ&&%log% autorun.inf copied|%ncr%
if not exist BZ\bz.ico copy bz.ico BZ&&%log% copied bz.ico|%ncr%
if exist latest.7z del latest.7z&&%log% latest.7z deleted|%ncr%
echo.
%log% Sanitize completed. Returning control to BZUpdate...|%ncr%
cls
echo.
goto end

:end
color 07
endlocal
exit