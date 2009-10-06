:: BootZilla Common Updater
:: for BootZilla v5.2+
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