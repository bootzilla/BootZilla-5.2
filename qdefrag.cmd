@echo off
cls
:: qUick Defrag for BootZilla
:: by Jim "jimmsta" Gall
:: February 26th, 2009
:: Defragments all BZ files after building BootZilla
::
echo.
echo QDefrag for BootZilla
echo Defragments BZ subdirectory after building BootZilla
echo.
echo Press CTRL-C to quit
echo.
jkdefragcmd.exe -a3 %CD%\BZ\