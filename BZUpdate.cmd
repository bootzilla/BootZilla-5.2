:main
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: GLOBAL/CONSTANT SETTINGS
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: GLOBAL constants and variables go up here
cls
setlocal
color F1
:: LOCAL constants and variables go below the 'setlocal' statement.
:: Set Working Directory to variable
set _cd=%cd%
:: If a new patch is installed, this is set to 1. If not, it is null.
set _npatch=
:: Is this an internal version of BZ?
set _isinternal=1
:: bz_options function uses this variable to determine menu choices
set _opt=
:: Variable for setting WGET Retries.
set _retries=3
:: This actually sets up the wg constant with options for the wget executable.
set wg=wget -N -a=bzlog.log -t %_retries%
:: set local variables
set bzver=5.2&set build=091006&set buildstat=Final
:: Set the build date of the files included, so that the new bz_upd code functions properly.
:: This also means that the updates for previous build numbers will be merged into commonupd.cmd (not definite)
set mdy=/D:08-31-2009
:: Set the root working directory as well as all other directories as variables.
set bzroot="BZ"&set util="BZ\Utils"&set mal="BZ\Malware"&set app="BZ\Apps"&set upd="updates"&set NT64=0
:: All of a sudden, I think I found why bootzilla is fucked up. The following line should explain it fairly well.
set u="BZ\Utils"&set m="BZ\Malware"&set a="BZ\Apps"
:: set logger path & :: set logfile to the entered value, set format to <date> <time>: <message>LINEFEED
set log=logger.exe&&set ncr=nocrlf.exe&&set LOGGER_OPTS="logfile=bzlog.log;FORMAT="$D $T: $M$_""
@echo off
if exist bzlog.log %log%|%ncr%
%log% [BootZilla v%bzver%-%build% %buildstat%] Build Log|%ncr%
%log% Working Directory: %_cd%|%ncr%
cls
:bz_menu
:: Set local variable that needs to be re-read following any setting changes
set wg=wget -N -t %_retries%
:: Loads the BootZilla Menu
cls
set _task=
set _bootcd=
cls
echo ***********************************
echo  BootZilla v%bzver%-%build% %buildstat%
if %_isinternal%==1 echo INTERNAL BUILD. DO NOT DISTRIBUTE^!
echo  www.bootzilla.org                                
echo ***********************************
echo [O] BootZilla Update Options
:: echo [U] Upgrade to BootZilla Full
echo                                 Download Size
echo                                 -------------
echo [1] Build BootZilla                     60MB
echo [2] Update BootZilla                   ~15MB
echo [3] Quick-Update BootZilla              ~5MB
echo -                       
echo [4] Build BootZilla Boot CD             12MB
echo -                                  
echo [5] Clean out old files       
echo [6] Read Changelog             -------------
::echo [AO] Run bz_addonpacks           User-Addons
echo.
echo                               Press ENTER to exit                                         
set /p _task=What would you like to do:

if "%_task%" == "" goto end
if "%_task%" == "1" goto bz_cdir
if "%_task%" == "2" goto bz_upd
if "%_task%" == "3" goto bz_qupd
if "%_task%" == "4" set _bootcd=1&&goto bz_boot
if "%_task%" == "5" goto bz_finisher
if "%_task%" == "6" goto bz_readlog
if "%_task%" == "O" goto bz_options
:: if "%_task%" == "AO" goto bz_addonpacks
:: if "%_task%" == "U" goto bz_upgrade

goto bz_menu

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: OPTIONS
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:bz_options
echo.
echo [P] Setup Proxy Server^:    %http_proxy%
echo [R] Reset Proxy Server Setting
echo [T] Set number of Retries to download files [%_retries%]
echo.
:: echo [ar] Enable Autorun without BootCD functionality [%_ar%]
echo [x64] 64-bit Downloads [%_optnt64%] - Enable/Disable
echo.
set /p _opt=What would you like to do: 

if "%_opt%" == "" goto bz_menu
if "%_opt%" == "P" goto bz_proxy
if "%_opt%" == "T" goto bz_retries
:: if "%_opt%" == "ar" set _ar=1
if "%_opt%" == "R" set http_proxy=&&set set_pxy=""&&%log% Reset Proxy Server to null values|%ncr%&&goto bz_menu
if "%_opt%" == "x64" set NT64=1&&set _optnt64="Enabled"&&%log% 64-bit Downloads enabled|%ncr%&&goto bz_menu
:: if "%_opt%" == "64e" set NT64=0&&set _optnt64="Disabled"&&%log% 64-bit Downloads disabled|%ncr%&&goto bz_menu
goto bz_menu

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: WGET SETTINGS
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:bz_retries
:: WGET Retries - how many times should WGET try to get a file?
echo.
set /p _retries=How many retries should WGET execute before skipping a file download? 

echo.
goto bz_menu

:bz_proxy
:: Set wget options in here.
:: http_proxy is a variable that WGET looks for, it is not defined outside of this function because it's not a local variable.
echo Proxy Settings
echo.
echo If you want to unset this, just press enter at the prompt.
echo.
set /p http_proxy=Enter your proxy server in http://username:password@xyz.com:PORT/ Format:  
  

echo.&&%log% Proxy Server: %http_proxy%|%ncr%
echo.
echo Proxy settings set. Re-starting script.
set_pxy="--proxy=on"
goto bz_menu

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: DIRECTORY CREATION
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:bz_cdir
%log% User chose to build BootZilla v%bzver%-%build%|%ncr%
call createdirs.cmd
:: Now we call the Sanitize script, which will delete any old files.
:: If the current version matches an updates staging cleaning definition file, shouldn't we execute it here as well?
echo Sanitizing BZ Sub-Directory...
start "" /wait sanitize.cmd
set LOGGER_OPTS="logfile=bzlog.log;FORMAT="$D $T: $M$_""
goto bz_build2

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: SLOW-BUILD BootZilla
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:bz_build2
:: Creates local cache of BootZilla files.
:: Check our dependencies first...
if not exist sanitize.cmd set sm=1&&goto bz_fileerror
if not exist wget.exe set wm=1&&goto bz_error
set LOGGER_OPTS="logfile=bzlog.log;FORMAT="$D $T: $M$_""
%log% Downloading BootZilla files...|%ncr%
echo.
echo.
echo *****************************
echo BootZilla v%bzver%-%build% %buildstat% Builder
echo www.bootzilla.org
echo by jimmsta
echo *****************************
echo.
echo. Download Process Starting - This may take a while.
:: If 7z.exe is missing, 7z.dll is probably missing too, so we download the latest versions from our repository.
if not exist 7z.exe %wg% http://www.bootzilla.org/5x/7z/7z.exe&&%wg% http://www.bootzilla.org/5x/7z/7z.dll&&%wg% http://www.bootzilla.org/5x/7z/7zS.sfx&&%log% Downloaded 7zip|%ncr%
:: if exist %u%\sysinternals\autoruns.exe del /f/s/q %u%\sysinternals\*.*&&%log% Removed old sysinternals tools|%ncr%
start "" /wait bz_utils.cmd
:: echo %errorlevel%
%log% Utils Downloaded|%ncr%
start "" /wait bz_apps.cmd
:: echo %errorlevel%
%log% Apps Downloaded|%ncr%
start "" /wait bz_mal.cmd
:: echo %errorlevel%
%log% ANTI-Malware Tools Downloaded|%ncr%
:: wget -N -i qmal.urls -P BZ/Malware/
:: %log% ANTI-Malware Tools Fully Updated|%ncr%
%log% Entering cleanup stage...|%ncr%
echo Performing Cleanup...
start "" /wait decompress.cmd
goto bz_finisher

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: UPDATE BootZilla [minilatest.7z]
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:bz_upd
%log% User chose to update BootZilla|%ncr%
:: version 5.0 introduces update staging and deployment
:: First, we grab the latest 7z.exe and 7z.dll file like the old code.
if not exist 7z.exe %wg% http://www.bootzilla.org/5x/7z/7z.exe&&%wg% http://www.bootzilla.org/5x/7z/7z.dll&&%log% Downloaded 7zip|%ncr%
:: Next, we grab the latest.7z file, and decompress it into BZ\updates\staging\
%wg% http://www.bootzilla.org/5x/p/minilatest.7z
7z.exe -y x minilatest.7z -o%upd%\staging\
:: Now we move the contents of BZ\updates\staging into the BZ folder, overwriting older files only.
xcopy %mdy% /S /Y %upd%\staging\*.* %CD%
:: And now, we make sure that the staging folder is clear of any remaining files
if exist %upd%\staging\BZUpdate.cmd del /F /S /Q updates\staging\*.*
:: Sometimes, there randomly appears to be a second staging directory, so here's some code to fix that.
if exist %upd%\staging\staging\nul set extst=1&&%log% Extra staging directory found|%ncr%
if extst==1 del /F /S /Q %upd%\staging\staging\*.*&&rmdir %upd%\staging\staging&&%log% Deleted extra staging directory|%ncr%
:: Now we tell the user to select Option 1 at the re-start of the script.
echo.
echo To continue updating, select Option 1 at the menu.
echo.
echo Restarting Script...
pause
:: %log% BootZilla v%bzver%-%build% Installed. Now restarting script...|%ncr%
set _npatch=1&&goto bz_menu

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: UPGRADE BootZilla [latest.7z method]
:: INTENDED for BZ-mini. Not used currently.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:bz_upgrade
%log% User chose to upgrade to the full BootZilla|%ncr%
:: version 5.0 mini supports upgrading to the full version of BootZilla
:: First make sure that our base package is up-to-date
%wg% http://www.bootzilla.org/5x/p/latest.7z
7z.exe -y x latest.7z -o%upd%\staging\
:: Now we move the contents of BZ\updates\stating into the BZ folder, overwriting older files only.
xcopy %mdy% /S /Y %upd%\staging\*.* %CD%
:: And now, we make sure that the staging folder is clear of any remaining files
if exist %upd%\staging\BZUpdate.cmd del /F /S /Q %upd%\staging\*.*
:: Now we tell the user to select Option 1 at the re-start of the script.
echo.
echo Select Option 1 once script re-starts.
echo.
pause
:: %log% BootZilla v%bzver%-%build% Installed. Now restarting script...|%ncr%
set _npatch=1&&goto bz_menu

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: QUICK-UPDATE BootZilla [bz_mal.cmd]
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:bz_qupd
:: Downloads a few updated Malware removal utilities.
%log% Quick Updating BootZilla...|%ncr%
start "" /wait bz_mal.cmd
goto bz_menu

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: UPDATES CLEANUP [bz_forceupd]
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:bz_cleanupd
:: CleanUpdate - Updates the local build of BootZilla with all the latest updates.
:: Cleans out all old files, and is custom-tailored to the version of BZ that currently resides on the machine.
:: Slightly Re-written for version 5.2
:: This is supposed to support v4.2.6 fine, as well as all v4.3.00 development versions, v5.0, 5.1, and released 5.2 builds equally.
:: If the build is older than 090915, we call Oldupds.cmd which cleans all builds from 4.2.7 thru 5.2 debug.
if %build% LEQ "090915" call %upd%\Oldupds.cmd
:: If the build is older than 080802, execute a 4.2.6 to 5.0 conversion script.
if %build% LEQ "080802" call %upd%\bz4to5.cmd
:: If the build variable set is older than 090915, set the build to 090915 and continue.
if %build% LEQ "090915" set build=090915
call %upd%\CommonUpd.cmd
call %upd%\%build%.cmd
goto bz_menu

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: BUILD BOOTCD
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:bz_boot
%log% User chose to build BootCD...|%ncr%
start "" /wait sanitize.cmd 
cls
if not exist 7z.exe %wg% http://www.bootzilla.org/5x/7z/7z.exe&&%wg% http://www.bootzilla.org/5x/7z/7z.dll&&%log% Downloaded 7zip|%ncr%
if not exist 7z.exe goto bz_error
:: First, we download and extract the latest release of CGT to the CGT subdirectory.
:: Secondly, we download any available patches for CGT and unzip them
%wg% http://www.bhtproject.org/library/BHT4x/CGTBoot.7z
7z.exe -y x CGTBoot.7z -oCGT -aoa -r
echo.
:: Check to see if there's any new patches for CGT, and download them.
wget -N http://www.bootzilla.org/5x/cgt/CGTpatch.7z
7z.exe -y x CGTpatch.7z -oCGT -aoa -r
echo.
:: We actually delete any older BZ directories in the CGT directory BEFORE copying BZ to the CGT directory.
echo Copying BootZilla to CGT directory.
rmdir /Q /S "CGT\BZ\"
MD "CGT\BZ"
:: The following isolinux.bin bit is old, and might be obsolete <OBSOLETE?>
xcopy /E /Y /H /I "CGT/isolinux/isolinux.bin" isolinux.bin
xcopy /E /Y /H /I BZ "CGT/BZ"
:: Now we make sure that we have the latest bz autorun app
:: This is included with all v5.1 releases, so we're not going to download it, but extract it into the CGT Directory.
:: 7z.exe -y x bzar5.7z -oCGT
echo.
echo Now Launching ImgBurn to Burn CD or Create Image File...
echo.
imgburn.exe /portable /MODE BUILD /OUTPUTMODE DEVICE /ROOTFOLDER YES /VERIFY NO /CLOSESUCCESS /SRC "bootzilla.ibb"
echo.
IF %ERRORLEVEL%==0 echo Image Burned Successfully.
pause
goto bz_menu

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: DISPLAY CHANGELOG
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:bz_readlog
echo.
notepad.exe changelog.txt
goto bz_menu

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: UPDATE AND INSTALL ADDONS
:: Not initialized yet, but the function exists...
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:bz_addonpacks
:: Scan for any additional bz_ao*.cmd files, not included with the default configuration
if exist bz_addons.cmd call bz_addons.cmd&&%log% BootZilla Addons Downloaded and Extracted.|%ncr%
:: Update any bz addons.
if exist bz_addons_upd.cmd call bz_addons_upd.cmd&&%log% BootZilla Addons Updated.|%ncr%
:: goto menu
goto bz_menu

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: FINISH BUILD PROCESS
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:bz_finisher
:: Removes unneeded files, cleans up the target directory and readies it for distribution.
echo.
%log% Sanitization stage...|%ncr%
call %upd%\CommonUpd.cmd
call %upd%\%build%.cmd
start "" /wait sanitize.cmd
echo.
:: Now we make sure that we have the latest bz autorun app
:: This is included with all v5.1 releases, so we're not going to download it, but extract it into the CGT Directory.
7z.exe -y x bzar5.7z -oBZ
if exist %upd%\%build%.cmd goto bz_cleanupd
set _task=
goto bz_menu

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ERROR MESSAGES
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:bz_fileerror
echo.
if sm=1 echo sanitize.cmd is missing. Please press enter.&&%log% sanitize.cmd is missing.|%ncr%
:: if sanitize is missing, we'll try to download the latest.7z and extract it. 
echo You are missing crucial files for the script to continue. 
echo I will try re-downloading the latest release, in hopes of fixing the problem for you
echo.
pause
%log% Error occured ^in dependencies. Re-downloading latest update.|%ncr%
goto bz_upd

:bz_error
echo.
echo Some sort of error occured. Check bzlog.log for more details.
echo.
if wm=1 echo Wget.exe is missing. Please go to bootzilla.org and download the latest release&&%log% wget.exe is missing.|%ncr%
pause
%log% Oh god how did this get here I'm ^not very good with computers|%ncr%
%log% Something is broken. Possibly a missing file on the server or something died.|%ncr%
%log% Unknown Error Occured. Please send this log to: jimmsta^@gmail.^com|%ncr%
echo.
goto bz_menu

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: END SCRIPT
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:end
echo ============
:: And now, we make sure that the staging folder is clear of any remaining files
if exist %upd%\staging\BZUpdate.cmd del /F /S /Q %upd%\staging\*.*
:: This logs that the user is exiting, and it resets the console colors to their defaults. Then it kills all the local variables and exits out of the session.
%log% User ^exit|%ncr%
color 07
endlocal
exit