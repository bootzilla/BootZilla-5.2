:: BootZilla v5.2 Build 091007 FINAL
if exist %m%\mbam-rules.exe del %m%\mbam-rules.exe&&%log%mbam-rules.exe|%ncr%
if exist %m%\eav_nt32_enu.msi del %m%\eav_nt32_enu.msi&&%log%eav_nt32_enu.msi|%ncr%
if exist %m%\eav_nt64_enu.msi del %m%\eav_nt64_enu.msi&&%log%eav_nt64_enu.msi|%ncr%