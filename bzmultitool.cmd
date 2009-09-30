:: BootZilla Multitool script
:: Includes SysVolInfoUnlock, Dismounter, and a new pagefile/hiberfil file remover.
@echo off
setlocal
color F1
:: Set all global variables here
set _task=
:: Menu
:menu
set _choice=
cls
echo.
echo BZ MultiTool
echo v1.00
echo For BootZilla v5+
echo.
echo [1] System Volume Info Unlocker
echo [2] Volume Dismounter
echo [3] Pagefile and Hiberfil file remover
echo.
set /p _choice=What would you like to run?  

if "%_choice%" == "" goto end
if "%_choice%" == "1" goto sysvol
if "%_choice%" == "2" goto dismount
if "%_choice%" == "3" goto pagedel

goto end


:sysvol
echo System Volume Information Unlocker
echo by jimmsta
echo version 1.01
echo.
echo.
set /p _task=Which Drive (letter) do you want to unlock? 
cacls "%_task%:\System Volume Information" /E /G %username%:F
echo.
echo The folder has been unlocked.
pause
goto menu


:dismount
set _drive=
cls
echo.
echo Safe Volume Dismounter
echo by jimmsta
echo version 1.01
echo.
echo.
set /p _drive=Which Drive (Letter) do you want to dismount^? 
echo.
echo Now dismounting drive %_drive%:...
fsutil volume dismount %_drive%^:
echo.
echo Drive "%_drive%^:" has been dismounted.
pause
goto menu

:pagedel
set _drive=
cls
echo.
echo Safe Pagefile and Hibernation file deleter
echo by jimmsta
echo version 1.00
echo.
echo.
set /p _drive1=Which Volume do you want to delete the files from^? 

if exist "%_drive1%:\pagefile.sys" attrib -H -R -S %_drive1%:\pagefile.sys&&del /f/s %_drive1%:\pagefile.sys
if exist "%_drive1%:\hiberfil.sys" attrib -H -R -S %_drive1%:\hiberfil.sys&&del /f/s %_drive1%:\hiberfil.sys
pause

goto menu

:end
endlocal