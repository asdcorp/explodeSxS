@if "%1" EQU "" exit /b 1
@if "%2" EQU "" exit /b 1

format X: /q /y >NUL 2>&1 || exit /b 1

mkdir X:\logs >NUL 2>&1 || exit /b 1
mkdir X:\temp >NUL 2>&1 || exit /b 1
mkdir X:\image >NUL 2>&1 || exit /b 1
mkdir X:\desktopimaging >NUL 2>&1 || exit /b 1

copy /y "%~dp0bin\sxsfounder.exe" X:\desktopimaging >NUL 2>&1 || exit /b 1
copy /y "%~dp0bin\cbsx.exe" X:\desktopimaging >NUL 2>&1 || exit /b 1

xcopy /cherkyq "%2" X:\desktopimaging >NUL 2>&1 || exit /b 1

X:\desktopimaging\sxsfounder.exe X:\image %1
