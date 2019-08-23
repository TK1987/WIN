@echo off &setlocal enabledelayedexpansion &title Farben aus Bildern entfernen

set CONF=C:\Config\Farben-entfernen.conf

if not exist "%CONF%" (call :Error "Konfigurationsdatei '%CONF%' existiert nicht."&goto :EoF) else (
	if "%~1" equ "" call :Error "Keine Datei zu bearbeiten."&goto :EoF)

for /f "usebackq" %%A in ("%CONF%") do (
	set /a COUNT+=1
	if !COUNT! gtr 2 (goto :next) else (set %%A)
	)

:next
for /f "usebackq skip=4" %%A in ("%CONF%") do set ERSETZE=-opaque %%A !ERSETZE!

echo Ersetze Farben %ERSETZE:-opaque =% mit %FARBTOLERANZ% Toleranz
echo.
for %%A in (%*) do (
	echo.|set /p ="Bearbeite '%%~nxA'... "
	magick convert -fill white -fuzz %FARBTOLERANZ% %ERSETZE% %%A "%TEMP%\%%~nxA" >nul 2>&1^
	&& move "%TEMP%\%%~nxA" "%%~dpnA%NAMENSZUSATZ%%%~xA" >nul 2>&1^
	&& echo erfolgreich. || echo Fehler bei Bearbeitung.
	)
goto :EoF

:Error
echo FEHLER^^! - %~1 &echo. &echo Beliebige Taste zum Beenden. &pause >nul
