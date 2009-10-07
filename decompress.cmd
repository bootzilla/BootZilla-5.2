cls
@echo off
setlocal
color F1
cls
echo.
echo *******************************
echo * BootZilla Decompress Script *
echo * Version 5.2                 *
echo * www.bootzilla.org           *
echo *******************************
echo.
echo Decompressing and Patching files. Please wait.
:: Decompress Mal-Utils
echo.
echo Decompressing Malware Utilities...
if exist BZ/Malware/gmer.zip 7z -y x BZ/Malware/gmer.zip -oBZ/Malware/
:: Decompress Utils
echo.
echo Decompressing Archived Utilities...
if exist BZ/Utils/UDPixel21_en.zip 7z -y x BZ/Utils/UDPixel21_en.zip -oBZ/Utils/
:: if %errorlevel% = 1 %log% File not found: UDPixel121_en.zip
if exist BZ/Utils/SysinternalsSuite.zip 7z -y x BZ/Utils/SysinternalsSuite.zip -oBZ/Utils/sysinternals/
if exist BZ/Utils/daf.zip 7z -y x BZ/Utils/daf.zip -oBZ/Utils/
if exist BZ/Utils/UKD_14-20_Beta.zip 7z -y e BZ/Utils/UKD_14-20_Beta.zip -oBZ/Utils/UnknownDevices
if exist BZ/Utils/lspfix.zip 7z -y x BZ/Utils/lspfix.zip -oBZ/Utils/lspfix/
if exist BZ/Utils/unstopcp.zip 7z -y x BZ/Utils/unstopcp.zip -oBZ/Utils/
if exist BZ/Utils/cpuz_151.zip 7z -y x BZ/Utils/cpuz_151.zip -oBZ/Utils/cpu-z/
:: if exist BZ/Utils/JS_Keyfinder_v106.zip 7z -y x BZ/Utils/JS_Keyfinder_v106.zip -oBZ/Utils/JS_Kf/
if exist BZ/Utils/erunt.zip 7z -y x BZ/Utils/erunt.zip -oBZ/Utils/erunt
if exist BZ/Utils/ZonedOut.zip 7z -y e BZ/Utils/ZonedOut.zip -oBZ/Utils/ZonedOut
:: RaProducts.org software
if exist BZ/Utils/JavaRa.zip 7z -y x BZ/Utils/JavaRa.zip -oBZ/Utils/
if exist BZ/Utils/PureRa13Binary.zip 7z -y x BZ/Utils/PureRa13Binary.zip -oBZ/Utils/
if exist BZ/Utils/ViewpointKiller.zip 7z -y x BZ/Utils/ViewpointKiller.zip -oBZ/Utils/ViewpointKiller/
if exist BZ/Utils/keyfinder.2.0.6.zip 7z -y x BZ/Utils/keyfinder.2.0.6.zip -oBZ/Utils/keyfinder/
echo.
goto end

:end
endlocal 
exit