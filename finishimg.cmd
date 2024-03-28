if not exist "X:\image\Windows\Setup\State" mkdir "X:\image\Windows\Setup\State"

echo:[State]>X:\image\Windows\Setup\State\State.ini
echo:ImageState=IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE>X:\image\Windows\Setup\State\State.ini>>X:\image\Windows\Setup\State\State.ini

REG.EXE LOAD HKLM\CBSS_SOFTWARE X:\image\Windows\System32\config\SOFTWARE || exit /b 1
REG.EXE LOAD HKLM\CBSS_SYSTEM X:\image\Windows\System32\config\SYSTEM || exit /b 1

REG.EXE IMPORT "%~dp0files\imagestate.reg" || exit /b 1

REG.EXE UNLOAD HKLM\CBSS_SOFTWARE || exit /b 1
REG.EXE UNLOAD HKLM\CBSS_SYSTEM || exit /b 1
