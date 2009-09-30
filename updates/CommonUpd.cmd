:: BootZilla Common Updater
:: for BootZilla v5+
if exist %bzroot%\index.html del %bzroot%\index.html&&%log% index.html|%ncr%
if exist %bzroot%\bz.ico del %bzroot%\bz.ico&&%log% bz.ico|%ncr%
if exist %bzroot%\readme.txt del %bzroot%\readme.txt&&%log% readme.txt|%ncr%
if exist %bzroot%\Utils\PC-Decrapifier-1.9.1.exe del %bzroot%\Utils\PC-Decrapifier-1.9.1.exe&&%log% PC-Decrapifier-1.9.1.exe|%ncr%
if exist %bzroot%\Malware\WindowsDefender.msi del %bzroot%\Malware\WindowsDefender.msi&&%log% WindowsDefender.msi|%ncr%
if exist %bzroot%\Malware\mpas-fe.exe del %bzroot%\Malware\mpas-fe.exe&&%log% mpas-fe.exe|%ncr%
if exist %bzroot%\Utils\cpuz_147.zip del %bzroot%\Utils\cpuz_147.zip&&%log% cpuz_147.zip|%ncr%
if exist %bzroot%\Utils\GPU-Z.0.2.7.exe del %bzroot%\Utils\GPU-Z.0.2.7.exe&&%log% GPU-Z.0.2.7.exe|%ncr%
if exist %bzroot%\Utils\cpuz_148.zip del %bzroot%\Utils\cpuz_148.zip&&%log% cpuz_148.zip|%ncr%
if exist %bzroot%\Utils\GPU-Z.0.2.8.exe del %bzroot%\Utils\GPU-Z.0.2.8.exe&&%log% GPU-Z.0.2.8.exe|%ncr%
if exist %bzroot%\Apps\victoria43SFX.exe del %bzroot%\Apps\victoria43SFX.exe&&%log% victoria43SFX.exe|%ncr%
:: Now we fix what we deleted -
if not exist BZ\readme.txt copy readme.txt BZ&&%log% readme.txt copied|%ncr%
if not exist BZ\changelog.txt copy changelog.txt BZ&&%log% changelog.txt copied|%ncr%
if not exist BZ\index.html copy index.html BZ&&%log% index.html copied|%ncr%
if not exist BZ\bzstyles.css copy bzstyles.css BZ&&%log% bzstyles.css copied|%ncr%
if not exist BZ\autorun.inf copy autorun.inf BZ&&%log% autorun.inf copied|%ncr%
if not exist BZ\bz.ico copy bz.ico BZ&&%log% copied bz.ico|%ncr%