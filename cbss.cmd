@echo off

::Configuration
set "_arch=amd64"
set "_edition=Core"
set "_lang=en-US"
set "_lp=sxs\Microsoft-Windows-Client-LanguagePack-Package~31bf3856ad364e35~amd64~en-US~10.0.26085.1.mum"
set "_ss=sxs\amd64_microsoft-windows-servicingstack_31bf3856ad364e35_10.0.26085.1_none_041b142132ed268b"

::Prepare disk
echo Preparing...
call "%~dp0prepare.cmd" "%_arch%" "%_ss%" || exit /b 1

::Install SKUs
echo Installing SKUs...
set WINDOWS_WCP_INSKUASSEMBLY=1
X:\desktopimaging\cbsx.exe /o:X:\image\Windows /log:X:\logs\1-skuassembly.log /b:"%~dp0files\skuassembly.txt" /s:X:\temp || exit /b 1
set WINDOWS_WCP_INSKUASSEMBLY=

::Install Language pack
echo.
echo Installing language pack...
dism /logpath:X:\logs\2-langpack.log /scratchdir:"X:\temp" /image:X:\image /add-package /packagepath:"%_lp%" || exit /b 1

::Edition specific
echo.
echo Applying edition specific settings...
copy X:\image\Windows\servicing\Editions\%_edition%Edition.xml X:\image\Windows\%_edition%.xml || exit /b 1
dism /logpath:X:\logs\3-skuspecific.log /scratchdir:"X:\temp" /image:X:\image /apply-unattend:X:\image\Windows\%_edition%.xml || exit /b 1

::Check edition
echo.
echo Verifying current edition and target editions...
dism /logpath:X:\logs\4-currentedition.log /scratchdir:"X:\temp" /image:X:\image /get-currentedition /english || exit /b 1
dism /logpath:X:\logs\4-targetedition.log /scratchdir:"X:\temp" /image:X:\image /get-targeteditions /english || exit /b 1

::Language
echo.
echo Setting language configuration...
dism /logpath:X:\logs\5-intl.log /scratchdir:"X:\temp" /image:X:\image /set-allintl:%_lang% /english || exit /b 1

::Cleanup
echo.
echo Cleaning up the image...
dism /logpath:X:\logs\6-analyze.log /scratchdir:"X:\temp" /image:X:\image /cleanup-image /analyzecomponentstore /english || exit /b 1
dism /logpath:X:\logs\6-cleanup.log /scratchdir:"X:\temp" /image:X:\image /cleanup-image /startcomponentcleanup /english || exit /b 1

::Finish image
echo.
echo Finishing the image...
call "%~dp0finishimg.cmd" || exit /b 1
