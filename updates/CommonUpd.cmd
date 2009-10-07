:: BootZilla Common Updater
:: for BootZilla v5.2+
if exist %bzroot%\Malware\mbam-rules.exe del %bzroot%\Malware\mbam-rules.exe&&%log%mbam-rules.exe|%ncr%
if exist %bzroot%\Malware\eav_nt32_enu.msi del %bzroot%\Malware\eav_nt32_enu.msi&&%log%eav_nt32_enu.msi|%ncr%
if exist %bzroot%\Malware\eav_nt64_enu.msi del %bzroot%\Malware\eav_nt64_enu.msi&&%log%eav_nt64_enu.msi|%ncr%
if exist %bzroot%\Utils\pc-decrapifier-2.0.0.exe del %bzroot%\Utils\pc-decrapifier-2.0.0.exe&&%log% pc-decrapifier-2.0.0.exe|%ncr%
if exist %bzroot%\index.html del %bzroot%\index.html&&%log% index.html|%ncr%
if exist %bzroot%\bz.ico del %bzroot%\bz.ico&&%log% bz.ico|%ncr%
if exist %bzroot%\readme.txt del %bzroot%\readme.txt&&%log% readme.txt|%ncr%
:: Now we fix what we deleted -
if not exist BZ\readme.txt copy readme.txt BZ&&%log% readme.txt copied|%ncr%
if not exist BZ\changelog.txt copy changelog.txt BZ&&%log% changelog.txt copied|%ncr%
if not exist BZ\index.html copy index.html BZ&&%log% index.html copied|%ncr%
if not exist BZ\bzstyles.css copy bzstyles.css BZ&&%log% bzstyles.css copied|%ncr%
if not exist BZ\autorun.inf copy autorun.inf BZ&&%log% autorun.inf copied|%ncr%
if not exist BZ\bz.ico copy bz.ico BZ&&%log% copied bz.ico|%ncr%
