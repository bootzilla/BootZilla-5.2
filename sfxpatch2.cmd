@echo off
cls
setlocal
:: SFX Patch2 v2.1
:: What it does: Decompresses a program, and any update files for it, and re-compresses the program into a 7zip-compressed SFX.
set _CD=%CD%
set logger=logger.exe
set nocrlf=nocrlf.exe
set wg=wget.exe
set _task=
:menu
:: This displays a menu to select what app you want to patch.
echo.
echo ****************
echo * SFX Patcher  *
echo * v2.1-090915  *
echo * by jimmsta   *
echo ****************
echo.
echo [idev] Install DevTools (this will be automatic later)
echo [1] Create Up-to-Date Silent Runners SFX
echo [2] Update Spybot Search and Destroy SFX
echo [3] Create Updated SmitfraudFix SFX
echo [4] Create Updated Testdisk/PhotoRec v6.1x-WIP SFX
echo [5] Create Updated TestDisk/PhotoRec v6.11 SFX
echo [6] Update Unknown Devices DeviceList.zip file...
echo [7] Download and patch Revo Uninstaller SFX
echo [8] Download and patch CCleaner Portable SFX
echo [9] Create Updated SIV SFX
echo.
echo                          Press ENTER to exit
echo.
set /p _task=Enter a choice to continue  

if "%_task%" == "" goto sfx_end
if "%_task%" == "1" goto sfx_silentrunners
if "%_task%" == "2" goto sfx_spybot
if "%_task%" == "3" goto sfx_sff
if "%_task%" == "4" goto sfx_bTDPR
if "%_task%" == "5" goto sfx_TDPR
if "%_task%" == "6" goto sfx_unkd
if "%_task%" == "7" goto sfx_revo
if "%_task%" == "8" goto sfx_cclean
if "%_task%" == "9" goto sfx_siv
if "%_task%" == "idev" cmd /k devsetup.cmd &&goto menu


goto sfx_end
:sfx_silentrunners
:: As it turns out, the official website for SilentRunners lists a vbs script file straight up, so there's no reason to not go ahead and get that file instead of using our Zipped copy.
wget -N "http://www.silentrunners.org/Silent Runners.vbs" -Otmp\SilentRunners.vbs
:: Create silentrunners.bat for SFX use....
cd tmp
if not exist silentrunners.bat echo cmd /k cscript SilentRunners.vbs > silentrunners.bat
:: pause
:: Now we re-compress the file as a 7z archive, for SFX uses
set _appname=SilentRunners
del SilentRunners.7z
del "Silent Runners.7z"
if exist config.txt del config.txt
:: Now we re-compress any vbs files into a 7z archive, using maximum compression settings
7z.exe a -t7z -m0=LZMA -mmt=on -mx9 -md=32m -mfb=64 -ms=on "%_appname%.7z" silentrunners.bat silentrunners.vbs
:: Next, we create a config.txt file...
:: set config.txt with format <message>LINEFEED
set logger=logger.exe
set nocrlf=nocrlf.exe
:: set options
set LOGGER_OPTS="logfile=config.txt;FORMAT="$M$_""
echo Now generating file...
echo.
%logger% ;!@Install@!UTF-8!|%nocrlf%
%logger% Title="Silent Runners SFX"|%nocrlf%
%logger% RunProgram="SilentRunners.bat"|%nocrlf%
%logger% ;!@InstallEnd@!|%nocrlf%
:: Now we reset the logger options to the default values
set LOGGER_OPTS="logfile=7zsfxmkr.log;FORMAT="$D $T: $M$_""
echo.
%logger% Config.txt file generated. |%nocrlf%
echo.
echo.
echo Now generating the sfx file...
copy /b 7zs.sfx + config.txt + SilentRunners.7z SilentRunnersSFX.exe
echo.
if exist config.txt del config.txt
if exist SilentRunners.7z del SilentRunners.7z
if exist SilentRunners.vbs del SilentRunners.vbs
%logger% SFX file created. Temp files deleted|%nocrlf%
copy SilentRunnersSFX.exe %_CD%\BZ\Utils\SilentRunnersSFX.exe
copy SilentRunnersSFX.exe %_CD%\BZ\Malware\SilentRunnersSFX.exe
pause
goto end

:sfx_spybot
:: based on: http://www.911cd.net/forums//index.php?showtopic=20385&view=findpost&p=136741
if not exist tmp\sbsd\nul MD tmp\sbsd
if not exist tmp\sbsd\spybotsd.exe wget -N http://www.bootzilla.org/5x/mal/sbsd.7z
if exist tmp\sbsd.7z 7z -y x tmp\sbsd.7z -otmp\sbsd
::if not exist tmp\sbsd\SpybotSD.exe copy BZ\Malware\SpybotSD_SFX.exe tmp\
cd tmp
::if not exist tmp\sbsd\SpybotSD.exe 7z -y x "SpybotSD_SFX.exe" -osbsd\
:: del /F/S/Q %_CD%\tmp\sbsd\Updates\*.*
:: rmdir /S /Q %_CD%\tmp\sbsd\Updates\
:: now we pull the latest updates off of the update servers and extract them into the INCLUDES folder.
wget.exe -N http://dl.betanews.com/spybot/updates/files/includes.dialer.zip
wget.exe -N http://dl.betanews.com/spybot/updates/files/includes.hijackers.zip
wget.exe -N http://dl.betanews.com/spybot/updates/files/includes.keyloggers.zip
wget.exe -N http://dl.betanews.com/spybot/updates/files/includes.malware.zip
wget.exe -N http://dl.betanews.com/spybot/updates/files/includes.pups.zip
wget.exe -N http://dl.betanews.com/spybot/updates/files/includes.security.zip
wget.exe -N http://dl.betanews.com/spybot/updates/files/includes.spybots.zip
wget.exe -N http://dl.betanews.com/spybot/updates/files/supplemental.zip
wget.exe -N http://dl.betanews.com/spybot/updates/files/includes.trojans.zip
wget.exe -N http://dl.betanews.com/spybot/updates/files/includes.zip
:: Now we extract all these wonderful files into the sbsd subfolder's includes folder.
%_CD%/7z.exe -y e includes.* -osbsd\Includes\
%_CD%/7z.exe -y e supplemental.zip -osbsd\Includes\ 
:: now we remove the zip files in the updates subfolder.
echo.
:: rmdir /S /Q tmp\sbsd\Updates\
if exist tmp\sbsd\SpybotSD_SFX.exe del tmp\sbsd\SpybotSD_SFX.exe
if exist tmp\SpybotSD_SFX.exe rmdir /S /Q tmp\SpybotSD_SFX.exe
:: And then we go ahead and re-compress the files into a new sbsd.7z file
cd sbsd
%_CD%/7z.exe a -t7z -r -m0=LZMA -mmt=on -mx9 -md=32m -mfb=64 -ms=on "sbsd.7z" "*.*"
:: and we move the file down a level
move sbsd.7z %_CD%\tmp
cd ..
if exist config.txt del /f/s/q config.txt
:: We then create a config.txt file from what we already know about the file...
set LOGGER_OPTS="logfile=config.txt;FORMAT="$M$_""
echo Now generating file...
echo.
%logger% ;!@Install@!UTF-8!|%nocrlf%
%logger% Title="Spybot Search and Destroy SFX"|%nocrlf%
%logger% RunProgram="SpybotSD.exe"|%nocrlf%
%logger% ;!@InstallEnd@!|%nocrlf%
:: Now we reset the logger options to the default values
set LOGGER_OPTS="logfile=7zsfxmkr.log;FORMAT="$D $T: $M$_""
echo.
%logger% Config.txt file generated. |%nocrlf%
:: Now we delete the old spybotsd_sfx.exe file..
if exist SpybotSD_SFX.exe del SpybotSD_SFX.exe
:: And then we copy /b the whole mess into a working sfx file...
copy /b 7zs.sfx + config.txt + sbsd.7z SpybotSD_SFX.exe
if exist config.txt del config.txt
copy SpybotSD_SFX.exe %_CD%\BZ\Malware\SpybotSD_SFX.exe
pause
goto end

:sfx_sff
:: SmitFraudFix SFX creator - Fixes what SiRi won't... or can't?
:: Why isn't SFF already an SFX that works on ReadOnly drives?
wget -N http://siri.geekstogo.com/SmitfraudFix.exe -P tmp\
:: if not exist tmp\sff\nul mkdir tmp\sff
cd tmp
7z -y x "SmitfraudFix.exe"
cd SmitfraudFix
%_CD%/7z.exe a -t7z -m0=LZMA -mmt=on -mx9 -md=32m -mfb=64 -ms=on "%_CD%/tmp/sff.7z" "*.*"
:: move "%_CD%/sff.7z" sff.7z
cd ..
set LOGGER_OPTS="logfile=config.txt;FORMAT="$M$_""
echo Now generating file...
echo.
%logger% ;!@Install@!UTF-8!|%nocrlf%
%logger% Title="SmitfraudFix SFX"|%nocrlf%
%logger% RunProgram="SmitfraudFix.cmd"|%nocrlf%
%logger% ;!@InstallEnd@!|%nocrlf%
:: Now we reset the logger options to the default values
set LOGGER_OPTS="logfile=7zsfxmkr.log;FORMAT="$D $T: $M$_""
echo.
%logger% Config.txt file generated. |%nocrlf%
:: And then we copy /b the whole mess into a working sfx file...
copy /b 7zs.sfx + config.txt + sff.7z SmitfraudfixSFX.exe
if exist config.txt del config.txt
copy SmitfraudfixSFX.exe %_CD%\BZ\Malware\SmitfraudfixSFX.exe
pause
goto end

:sfx_bTDPR
:: TestDisk and PhotoRec v6.x WIP Patcher
wget -N http://www.cgsecurity.org/testdisk-6.12-WIP.win.zip -P tmp\
cd tmp
if not exist testdisk\nul MD testdisk
7z.exe -y x testdisk-6.12-WIP.win.zip -otestdiskWIP
if not exist testdiskWIP\testdisk-6.12-WIP\win\selector.cmd copy %_CD%\tmp\selector.cmd %_CD%\tmp\testdiskWIP\testdisk-6.12-WIP\win\selector.cmd
cd testdiskWIP
cd testdisk-6.12-WIP
cd win
::copy %_CD%/tmp/testdisk/
%_CD%/7z.exe a -t7z -r -m0=LZMA -mmt=on -mx9 -md=32m -mfb=64 -ms=on "testdisk.7z" "*"
move testdisk.7z %_CD%/tmp/testdisk.7z
cd ..
cd ..
cd ..
set LOGGER_OPTS="logfile=config.txt;FORMAT="$M$_""
echo Now generating file...
echo.
%logger% ;!@Install@!UTF-8!|%nocrlf%
%logger% Title="TestDisk and PhotoRec v6.12 WIP SFX"|%nocrlf%
%logger% RunProgram="selector.cmd"|%nocrlf%
%logger% ;!@InstallEnd@!|%nocrlf%
:: Now we reset the logger options to the default values
set LOGGER_OPTS="logfile=7zsfxmkr.log;FORMAT="$D $T: $M$_""
echo.
%logger% Config.txt file generated. |%nocrlf%
:: And then we copy /b the whole mess into a working sfx file...
copy /b 7zs.sfx + config.txt + testdisk.7z testdiskWIP.7zSFX.exe
if exist config.txt del config.txt
copy testdisk.7zSFX.exe %_CD%\BZ\Utils\testdisk.7zSFX.exe
pause
goto end

:sfx_TDPR
:: TestDisk and PhotoRec v6.x WIP Patcher
:: Re-write version - fixed finally, after 6+ months of being broken.
wget -N http://www.cgsecurity.org/testdisk-6.11.3.win.zip -P tmp\
cd tmp
if not exist testdisk\nul MD testdisk
7z.exe -y x testdisk-6.11.3.win.zip -otestdisk
if not exist testdisk\testdisk-6.11.3\win\selector.cmd copy %_CD%\tmp\selector.cmd %_CD%\tmp\testdisk\testdisk-6.11.3\win\selector.cmd
cd testdisk
cd testdisk-6.11.3
cd win
::copy %_CD%/tmp/testdisk/
%_CD%/7z.exe a -t7z -r -m0=LZMA -mmt=on -mx9 -md=32m -mfb=64 -ms=on "testdisk.7z" "*"
move testdisk.7z %_CD%/tmp/testdisk.7z
cd ..
cd ..
cd ..
set LOGGER_OPTS="logfile=config.txt;FORMAT="$M$_""
echo Now generating file...
echo.
%logger% ;!@Install@!UTF-8!|%nocrlf%
%logger% Title="TestDisk and PhotoRec v6.11.3 SFX"|%nocrlf%
%logger% RunProgram="selector.cmd"|%nocrlf%
%logger% ;!@InstallEnd@!|%nocrlf%
:: Now we reset the logger options to the default values
set LOGGER_OPTS="logfile=7zsfxmkr.log;FORMAT="$D $T: $M$_""
echo.
%logger% Config.txt file generated. |%nocrlf%
:: And then we copy /b the whole mess into a working sfx file...
copy /b 7zs.sfx + config.txt + testdisk.7z testdisk.7zSFX.exe
if exist config.txt del config.txt
copy testdisk.7zSFX.exe %_CD%\BZ\Utils\testdisk.7zSFX.exe
pause
goto end

:sfx_unkd
:: First we create a new directory in tmp and grab the old DeviceLists.zip file
if not exist tmp\unkd\nul MD tmp\unkd
if not exist tmp\unkd\DeviceLists.zip copy BZ\Utils\UnknownDevices\DeviceLists.zip tmp\unkd\
cd tmp
:: then we decompress the files
7z.exe -y x unkd\DeviceLists.zip -ounkd
:: then grab the latest using wget -N switch
wget -N http://rh-software.com/downloads/usbdevs.txt -P unkd\ 
wget -N http://members.datafast.net.au/dft0802/downloads/pcidevs.txt -P unkd\
wget -N http://www.bhtproject.org/library/BHT4x/patches/chpsdevs.txt -P unkd\
:: and recompress the zip file
:: if exist DeviceLists.zip del DeviceLists.zip
:: This seems to be very touchy - UNKD will only read bog-standard ZIP files
%_CD%\7z.exe a -tzip "DeviceLists.zip" %_CD%/tmp/unkd/*.txt
:: then place the file back where it belongs.
copy DeviceLists.zip %_CD%\BZ\Utils\UnknownDevices\
pause
if exist config.txt del config.txt
goto end

:sfx_siv
if not exist tmp\siv\nul MD tmp\siv
:: Download and extract latest SIV executables
wget http://rh-software.com/downloads/siv.zip -P tmp\
:: Extract phase
cd tmp
7z.exe -y x siv.zip -osiv 
:: Grab the latest pci/usb/chips device lists like sfx_unkd function does and save to directory that SIV will run from.
wget -N http://members.datafast.net.au/dft0802/downloads/pcidevs.txt -P siv\
wget -N http://rh-software.com/downloads/usbdevs.txt -P siv\
wget -N http://rh-software.com/downloads/mondevs.txt -P siv\
wget -N http://rh-software.com/downloads/pcmdevs.txt -P siv\
:: Recompress the mess into a new 7z archive
cd siv
%_CD%/7z.exe a -t7z -r -m0=LZMA -mmt=on -mx9 -md=32m -mfb=64 -ms=on "siv.7z" "*"
move siv.7z %_CD%\tmp
:: Do our custom config.txt configuration and dump out a useable SFX.
cd ..
set LOGGER_OPTS="logfile=config.txt;FORMAT="$M$_""
echo Now generating file...
echo.
%logger% ;!@Install@!UTF-8!|%nocrlf%
%logger% Title="System Information Viewer SFX"|%nocrlf%
%logger% RunProgram="siv.exe"|%nocrlf%
%logger% ;!@InstallEnd@!|%nocrlf%
:: Now we reset the logger options to the default values
set LOGGER_OPTS="logfile=7zsfxmkr.log;FORMAT="$D $T: $M$_""
echo.
%logger% Config.txt file generated. |%nocrlf%
:: And then we copy /b the whole mess into a working sfx file...
if exist siv_SFX.exe del /f/s siv_SFX.exe
copy /b 7zs.sfx + config.txt + siv.7z siv_SFX.exe
if exist config.txt del config.txt
copy siv_SFX.exe %_CD%\BZ\Utils\siv_SFX.exe
pause
goto end

:sfx_cclean
if not exist tmp\ccleaner\nul MD tmp\ccleaner
:: Download and extract latest CCleaner Portable executables
wget -N http://www.bootzilla.org/5x/utils/ccsetup223.zip -P tmp\
:: Extract phase
cd tmp
7z.exe -y x ccsetup223.zip -occleaner 
:: Grab the latest 'custom winapps' addon
wget -N http://www.bootzilla.org/5x/utils/winapps.zip
7z.exe -y e winapps.zip -occleaner
:: Recompress the mess into a new 7z archive
cd ccleaner
%_CD%/7z.exe a -t7z -r -m0=LZMA -mmt=on -mx9 -md=32m -mfb=64 -ms=on "ccleaner.7z" "*"
move ccleaner.7z %_CD%\tmp
:: Do our custom config.txt configuration and dump out a useable SFX.
cd ..
if exist config.txt del config.txt
set LOGGER_OPTS="logfile=config.txt;FORMAT="$M$_""
echo Now generating file...
echo.
%logger% ;!@Install@!UTF-8!|%nocrlf%
%logger% Title="CCleaner Portable SFX"|%nocrlf%
%logger% RunProgram="ccleaner.exe"|%nocrlf%
%logger% ;!@InstallEnd@!|%nocrlf%
:: Now we reset the logger options to the default values
set LOGGER_OPTS="logfile=7zsfxmkr.log;FORMAT="$D $T: $M$_""
echo.
%logger% Config.txt file generated. |%nocrlf%
:: And then we copy /b the whole mess into a working sfx file...
copy /b 7zs.sfx + config.txt + ccleaner.7z ccleanerSFX.exe
if exist config.txt del config.txt
pause
:: Copy into proper BZ Folder...
copy ccleanerSFX.exe %_CD%\BZ\Utils\ccleanerSFX.exe
goto end

:sfx_revo
:: Currently broken for unknown reason.
:: First we get the latest revo uninstaller zip file from the Official site
if not exist tmp\revouninstaller-portable echo Revo Uninstaller not yet patched.
if exist tmp\revouninstaller-portable\revouninstaller.exe del tmp\revouninstaller-portable\revouninstaller.exe
wget -N http://www.revouninstaller.com/revouninstaller.zip
:: Since the zip file is already set up for portable use, we will extract it into the tmp folder without creating a new subfolder first
7z.exe -y x revouninstaller.zip -otmp\
cd tmp
cd revouninstaller-portable
%_CD%/7z.exe a -t7z -m0=LZMA -mmt=on -mx9 -md=32m -mfb=64 -ms=on "revouninstaller.7z" "*"
move revouninstaller.7z %_CD%/tmp/revouninstaller.7z
cd ..
set LOGGER_OPTS="logfile=config.txt;FORMAT="$M$_""
echo Now generating file...
echo.
%logger% ;!@Install@!UTF-8!|%nocrlf%
%logger% Title="Revo Uninstaller Portable SFX"|%nocrlf%
%logger% RunProgram="Revouninstaller.exe"|%nocrlf%
%logger% ;!@InstallEnd@!|%nocrlf%
:: Now we reset the logger options to the default values
set LOGGER_OPTS="logfile=7zsfxmkr.log;FORMAT="$D $T: $M$_""
echo.
%logger% Config.txt file generated. |%nocrlf%
:: And then we copy /b the whole mess into a working sfx file...
copy /b 7zs.sfx + config.txt + revouninstaller.7z RevoUninstallerSFX.exe
if exist config.txt del config.txt
:: Copy into the proper BZ Folder.
copy RevoUninstallerSFX.exe %_CD%\BZ\Utils\
pause
goto end

:sfx_end
endlocal
exit

:end
endlocal
goto sfx_end

:eof
endlocal