@echo off
setlocal
:: BuildPackage.cmd
:: Builds a set of tools and BootZilla packages for deployment
:: version and build stated below in pkgver and buildv variables.
:: Updated for v5.2
set pkgver=2.0
set buildv=090915
:: frelease variable is the command line to build a FULL Release package <includes 7zip files>
set frelease=7z.exe a -tzip -md=32m -mfb=64 "bz5release.zip" imgburn.exe jkdefragcmd.exe qdefrag.cmd bzar5.7z msistub.exe selector.cmd bzmultitool.cmd createdirs.cmd 7zsfxmkr31.cmd sfxpatch2.cmd 7zS.sfx devsetup.cmd msvcr71.dll bz_mal.cmd bz_utils.cmd bz_apps.cmd 7z.exe 7z.dll index.html bzstyles.css bz.ico mkisofs.exe logger.exe nocrlf.exe wget.exe license.txt isolinux.bin Readme.txt decompress.cmd changelog.txt BZUpdate.cmd sanitize.cmd BuildPackage.cmd updates\ updates\*
:: patch variable is the command line to build a 7zip minilatest.7z package of necessary bootzilla files
set patch=7z.exe a -t7z -m0=LZMA -mmt=on -mx9 -md=64m -mfb=64 -ms=on "minilatest.7z" bzar5.7z createdirs.cmd bz_mal.cmd bz_utils.cmd bz_apps.cmd index.html bzstyles.css bz.ico Readme.txt decompress.cmd sanitize.cmd BZUpdate.cmd changelog.txt BuildPackage.cmd updates\ updates\*
:: devtools variable is the command line to build a 7zip compressed devtools.7z package of necessary development bootzilla files
set devtools=7z.exe a -t7z -m0=LZMA -mmt=on -mx9 -md=64m -mfb=64 -ms=on "devtools.7z" msistub.exe selector.cmd createdirs.cmd msvcr71.dll 7zsfxmkr31.cmd sfxpatch2.cmd BuildPackage.cmd devsetup.cmd 7z.exe 7z.dll 7zS.sfx mkisofs.exe
:: Almost forgot that I needed to add a 7zip-compressed version of the frelease, for v4.2 users to upgrade to.
set frup=7z.exe a -t7z -m0=LZMA -mmt=on -mx9 -md=64m -mfb=64 -ms=on "latest.7z" imgburn.exe jkdefragcmd.exe qdefrag.cmd bzar5.7z msistub.exe selector.cmd bzmultitool.cmd createdirs.cmd 7zsfxmkr31.cmd sfxpatch2.cmd 7zS.sfx devsetup.cmd msvcr71.dll bz_mal.cmd bz_utils.cmd bz_apps.cmd 7z.exe 7z.dll index.html bzstyles.css bz.ico mkisofs.exe logger.exe nocrlf.exe wget.exe license.txt isolinux.bin Readme.txt decompress.cmd changelog.txt BZUpdate.cmd sanitize.cmd BuildPackage.cmd updates\ updates\*
::
cls
color 71
echo.
echo **********************************
echo * BootZilla mini package builder *
echo * v%pkgver%-%buildv%             *
echo * for BootZilla v5.2             *
echo **********************************
echo.
echo Building Packages...
echo.
:: If any old patches exist, they'll be moved to old_xxx.yyy files. This way, if something goes wrong, you can go back to the last build.
if exist minilatest.7z move minilatest.7z old_minilatest.7z
if exist latest.7z move latest.7z old_latest.7z
if exist bz5release.zip move bz5release.zip old_bz5r.zip
if exist devtools.7z move devtools.7z old_devtools.7z
::%release%
%patch%
%frelease%
%devtools%
%frup%
pause
echo Packages have been built.
endlocal
exit