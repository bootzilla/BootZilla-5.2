@echo off
cls
setlocal
:: set logger path
set logger=logger.exe
set nocrlf=nocrlf.exe
:: set logfile to the entered value, set format to <date> <time>: <message>LINEFEED
set LOGGER_OPTS="logfile=7zsfxmkr.log;FORMAT="$D $T: $M$_""
:reset
:: Set local variables...
set _zarc=
set _title=
set _runprog=
:: We recieve the following variables from elsewhere-
:: _archive, _filetitle, _filename
%logger%|%nocrlf%
%logger% 7zip SFX Maker script started|%nocrlf%
if exist config.txt del config.txt
if not exist 7zS.sfx goto error
color F1
cls
:menu
echo.
echo *****************
echo * 7zipSFXMaker  * 
echo * v3.20-080828  *
echo * by jimmsta    *
echo * bootzilla.org *
echo *****************
echo.
echo.
echo.
:: _archive can be set by another script outside of this one, for future use
::set _zarc=_archive
:: if _zarc == "" 
set /p _zarc=Please type the 7zip file name: 

echo.
if %_zarc% =="" goto end
echo You have typed %_zarc%
echo.
:: Now we want to unzip the archive into a temp directory, and get the filename out of the main program file
:: then, we set _title to the value returned(_filetitle), and let the script progress without user interaction (I guess)
::set _title = _filetitle
::if _title == "" 
set /p _title=Please type the title of the software: 

echo.
echo You have typed %_title%
echo.
:: Next, we want to find the main exe file name and shove its name into _runprog
::set _runprog = _filename
::if _runprog == "" 
set /p _runprog=Run Program after SFX extracted: 

echo.
echo You have typed %_runprog%
echo.
:: set logfile to the entered value, set format to <date> <time>: <message>LINEFEED
set LOGGER_OPTS="logfile=config.txt;FORMAT="$M$_""
echo Now generating file...
%logger% ;!@Install@!UTF-8!|%nocrlf%
%logger% Title="%_title%"|%nocrlf%
%logger% RunProgram="%_runprog%"|%nocrlf%
%logger% ;!@InstallEnd@!|%nocrlf%
:: Now we reset the logger options to the default values
set LOGGER_OPTS="logfile=7zsfxmkr.log;FORMAT="$D $T: $M$_""
echo.
cls
echo Now typing the config file out...
echo.
echo.
type config.txt
echo.
echo.
%logger% Config.txt file generated. |%nocrlf%
echo.
echo.
echo Now generating the sfx file...
set _sfxname=%_zarc%SFX.exe
echo.
copy /b 7zs.sfx + config.txt + %_zarc% %_sfxname%
echo.
echo Cleaning filename...
:: ren %_sfxname% %_zarc%_SFX.exe
echo.
echo File renamed to: %_zarc%_SFX.exe
%logger% SFX file created.|%nocrlf%
echo.
pause
goto reset

:error
echo.
echo You are missing critical files for this script to function properly.
echo Please ensure that you have 7zS.sfx in your 7zipSFXBuilder directory.
echo.
pause
goto end

:xtract
mkdir %_appname%
7za.exe e -aou -o%_appname%\ -pdefault %_origfile%
7za.exe a -t7z -m0=LZMA -mmt=on -mx9 -md=32m -mfb=64 -ms=on "%_appname%.7z" "%_appname%\*.*"
del %_origfile%

goto menu
:end
%logger%|%nocrlf%
endlocal