:: BootZilla v5.2 Build 090915
if exist %u%\cpuz_148.zip del %u%\cpuz_148.zip&&%log% cpuz_148.zip|%ncr%
if exist %u%\cpuz_149.zip del %u%\cpuz_149.zip&&%log% cpuz_149.zip|%ncr%
if exist %u%\cpuz_150.zip del %u%\cpuz_150.zip&&%log% cpuz_150.zip|%ncr%
if exist %u%\cpuz_152.zip del %u%\cpuz_152.zip&&%log% cpuz_152.zip|%ncr%
if exist %m%\SuperAntiSpyware.exe del %m%\SuperAntiSpyware.exe&&%log% SuperAntiSpyware.exe|%ncr%
if exist %m%\RogueRemoverSFX.exe del %m%\RogueRemoverSFX.exe&&%log% RogueRemoverSFX.exe|%ncr%
if exist %a%\7z463.exe del %a%\7z463.exe&&%log% 7z463.exe|%ncr%
if exist %a%\7z465.exe del %a%\7z464.exe&&%log% 7z464.exe|%ncr%
if exist %a%\7z459.exe del %a%\7z459.exe&&%log% 7z459.exe|%ncr%
if exist %u%\GPU-Z.0.3.1.exe del %u%\GPU-Z.0.3.1.exe&&%log% GPU-Z.0.3.1.exe|%ncr%
if exist %u%\GPU-Z.0.3.2.exe del %h%\GPU-Z.0.3.2.exe&&%log% GPU-Z.0.3.2.exe|%ncr%
if exist %u%\GPU-Z.0.3.3.exe del %h%\GPU-Z.0.3.3.exe&&%log% GPU-Z.0.3.3.exe|%ncr%
if exist %u%\GPU-Z.0.3.4.exe del %h%\GPU-Z.0.3.4.exe&&%log% GPU-Z.0.3.4.exe|%ncr%

:: This should all be done in an if loop with an errorlevel return value each run. Must read up on how to do that.