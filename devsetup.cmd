:: devsetup.cmd
@echo off
setlocal
:: *****************************************
::  BootZilla v5.2 Development toolkit 
::  v1.1                          
:: *****************************************
::
if not exist tmp/nul mkdir tmp
copy 7z.exe tmp
copy 7z.dll tmp
copy 7zS.sfx tmp
copy wget.exe tmp
copy logger.exe tmp
copy nocrlf.exe tmp
copy 7zSFXmkr31.cmd tmp
copy msistub.exe tmp
copy selector.cmd tmp
copy mkisofs.exe tmp
if not exist 7z.exe echo FAIL. 7z.exe missing
echo.
echo Devtools Setup in tmp folder.
echo.
pause
endlocal
exit
