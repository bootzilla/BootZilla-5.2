:: BootZilla Directory Creation Script
:: version 2.0
:: For All versions of BootZilla 5.1 thru 5.2.
:: bootzilla.org
cls
echo.
echo Creating Required Directories...
echo.
:: Make Base Directory Tree
:: Updates folders (v5 feature)
if not exist updates\nul MD updates
if not exist updates\staging\nul MD updates\staging
:: Base directories...
if not exist CGT\nul MD CGT
if not exist BZ\nul MD BZ
if not exist tmp\nul MD tmp
:: Apps
if not exist BZ\Apps\nul MD BZ\Apps
:: Malware
if not exist BZ\Malware\nul MD BZ\Malware
:: Utils - also checks for, and removes old entries no longer supported or used.
if not exist BZ\Utils\UnknownDevices\nul MD BZ\Utils\UnknownDevices
if not exist BZ\Utils\sysinternals\nul MD BZ\Utils\sysinternals
if not exist BZ\Utils\lspfix\nul MD BZ\Utils\lspfix
:: if not exist BZ\Utils\RegScanner\nul MD BZ\Utils\RegScanner
if not exist BZ\Utils\Dial-a-fix-full\nul MD BZ\Utils\Dial-a-fix-full
if not exist BZ\Utils\erunt\nul MD BZ\Utils\erunt
if not exist BZ\Utils\keyfinder\nul MD BZ\Utils\keyfinder
:: Old DevSetup script follows. Added due to rage.
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

%log% All Directories Created, Dev files placed.|%ncr%
