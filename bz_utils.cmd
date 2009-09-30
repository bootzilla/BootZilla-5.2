@echo off
cls
setlocal
color F1
:: bz_utils.cmd
:: Downloads the latest utilities from the bootzilla server.
:: New variable (v4.2.6) for setting WGET Retries.
set _retries=3
:: This actually sets up the wg constant/variable below.
set wg=wget -N -t %_retries%
:: 
echo.
:: First we do exe files, then we do compressed files (due to if exist and if not exist statements)
%wg% http://www.bootzilla.org/5x/utils/ATF-Cleaner.exe -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% ATF-Cleaner.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/utils/AutoBackupSFX.exe -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% AutoBackupSFX.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/utils/EZPCFix-1-0-0-16.exe -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% EZPCFix-1-0-0-16.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/utils/unstopcp.exe -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% unstopcp.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/utils/WinsockFix-XP.exe -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% WinsockFix-XP.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/utils/testdisk.7zSFX.exe -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% testdisk.7zSFX.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/utils/siv_SFX.exe -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% siv_SFX.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/utils/ccleanerSFX.exe -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% ccleanerSFX.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/utils/FSOptimizerSFX.exe -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% FSOptimizerSFX.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/utils/RevoUninstallerSFX.exe -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% RevoUninstallerSFX.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/utils/regalyz.exe -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% regalyz.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/utils/pc-decrapifier-2.0.0.exe -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% pc-decrapifier-2.0.0.exe failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/utils/StartUpLite.exe -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% StartUpLite.exe failed to download|%ncr%)
%wg% http://download.mcafee.com/products/licensed/cust_support_patches/MCPR.exe -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% MCPR.exe failed to download|%ncr%)
%wg% ftp://ftp.symantec.com/public/english_us_canada/removal_tools/Norton_Removal_Tool.exe -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% Norton_Removal_Tool.exe failed to download|%ncr%)
::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Compressed files
::::::::::::::::::::::::::::::::::::::::::::::::::::::
if not exist BZ/Utils/lspfix/lspfix.exe %wg% http://www.bootzilla.org/5x/utils/lspfix.zip -P BZ/Utils
IF %ERRORLEVEL%==1(%log% lspfix.zip failed to download|%ncr%)
if not exist BZ/Utils/UnknownDevices/DeviceLists.zip %wg% http://www.bootzilla.org/5x/utils/UKD_14-20_Beta.zip -P BZ/Utils
IF %ERRORLEVEL%==1(%log% DeviceLists.zip failed to download|%ncr%)
if not exist BZ/Utils/erunt/erunt.exe %wg% http://www.bootzilla.org/5x/utils/erunt.zip -P BZ/Utils
IF %ERRORLEVEL%==1(%log% erunt.zip failed to download|%ncr%)
if not exist "BZ/Utils/dial-a-fix-full/dial-a-fix.exe" %wg% http://www.bootzilla.org/5x/utils/daf.zip -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% daf.zip failed to download|%ncr%)
:: Now we get Sysinternals tools and log it.
%wg% http://live.sysinternals.com/Tcpview.exe -P BZ/Utils/sysinternals/
IF %ERRORLEVEL%==1(%log% Tcpview.exe failed to download|%ncr%)
%wg% http://live.sysinternals.com/autoruns.exe -P BZ/Utils/sysinternals/
IF %ERRORLEVEL%==1(%log% autoruns.exe failed to download|%ncr%)
%wg% http://live.sysinternals.com/procexp.exe -P BZ/Utils/sysinternals/
IF %ERRORLEVEL%==1(%log% procexp.exe failed to download|%ncr%)
:: Other compressed utuils...
%wg% http://www.bootzilla.org/5x/utils/cpuz_152.zip -P BZ/Utils
IF %ERRORLEVEL%==1(%log% cpuz_152.zip failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/utils/JavaRa.zip -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% JavaRa.zip failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/utils/PureRa14binary.zip -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% PureRa14binary.zip failed to download|%ncr%)
%wg% http://www.bootzilla.org/5x/utils/keyfinder.2.0.6.zip -P BZ/Utils/
IF %ERRORLEVEL%==1(%log% keyfinder.2.0.6.zip failed to download|%ncr%)
:end
endlocal
exit