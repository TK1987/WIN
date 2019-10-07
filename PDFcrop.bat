:: Fenstereinstellungen ::
	@echo off
	title PDFcrop installieren und konfigurieren
	setlocal enabledelayedexpansion
	cls &color 07 &mode con cols=120 lines=15

:: Variablen - WP="Arbeitspfad" ::
	set WP=%SYSTEMDRIVE%\MSiT

:: Falls als 2. Instanz gestartet, gehe zu Sprungmarke :Admin, sonst starte 2. Instanz als Admin ::
	if "%~1" equ "Admin" (goto :Admin) else (
		for /f "Tokens=2 delims=," %%A in ('tasklist /fi "Windowtitle eq PDFcrop*" /nh /fo csv') do set PID=%%~A
		start /min powershell start -windowstyle hidden -verb runas %0 "Admin,%USERNAME%,!PID!")

:: Erstelle Arbeitspfad ::
	mkdir %WP% 2>nul &cd %WP%

:: Downloade wget, falls es nicht existiert ::
	ping /n 1 8.8.8.8 >nul ||goto :noInet
	where wget >nul 2>&1 ||powershell wget https://github.com/TK1987/WIN/raw/master/tools/wget.exe -outfile wget.exe

:: rufe Download von Strawberry und Miktex auf ::
	call :download "Strawberry" "http://strawberryperl.com/download/5.30.0.1/strawberry-perl-5.30.0.1-64bit.msi" || goto :EoF
	call :download "Miktex" "https://miktex.org/download/ctan/systems/win32/miktex/setup/windows-x64/basic-miktex-2.9.7152-x64.exe" || goto :EoF

:: Erstelle Script um PDFs zuzuschneiden ::
	mkdir %APPDATA%\script 2>nul
	echo @echo off > "%APPDATA%\script\PDFcrop.bat"
	echo cd %%tmp%% >> "%APPDATA%\script\PDFcrop.bat"
	echo for %%%%A in (^%%^*) do ( >> "%APPDATA%\script\PDFcrop.bat"
	echo echo. ^|set /p="%%%%~nxA wird zugeschnitten... " >> "%APPDATA%\script\PDFcrop.bat"
	echo pdfcrop %%%%A %%%%A ^>nul 2^>^&1 ^&^& echo erfolgreich. ^|^| echo fehler.) >> "%APPDATA%\script\PDFcrop.bat"
	Powershell $SC=(new-object -comobject wscript.shell).createshortcut('%APPDATA%\Microsoft\Windows\SendTo\PDFs zuschneiden.lnk');^
		$SC.targetpath='%APPDATA%\script\PDFcrop.bat';^
		$SC.iconlocation='%WINDIR%\system32\shell32.dll,259';^
		$SC.save()

:: Setze Path-Variable temporär neu ::
	set ST=%systemdrive%\Strawberry
	set path=%path%%ST%\c\bin;%ST%\perl\site\bin;%ST%\perl\bin;%Programfiles%\MiKTeX 2.9\miktex\bin\x64;

:: Schließe Installation ab :: 
	cls
	title Installation abschliessen
	mode con cols=80 lines=5
	echo Warte auf Ende der Installation. Fenster bitte nicht schliessen.
	:Beende
		if not exist done (timeout 10 /nobreak >nul &goto :Beende)
		cls &echo Konfiguriere PDFcrop ^& bereinige Installationsdaten.
		cd ..
		rd /s /q %WP%
		pdfcrop --help > nul 2>&1
		del "%~0" 2>nul
		goto :EoF

:: Downloade Strawberry und Miktex ::
	:download
		ping /n 1 8.8.8.8 >nul || goto :noInet
		for %%A in (%2) do (
			if exist %%~nxA (if not exist %~1.txt (echo. >%~1)) else (
					wget --no-check-certificate %%A
					call :download %*
					))
		goto :EoF

:: Fehler, falls keine Internetverbindung ::
	:noInet
		cls
		echo Derzeit besteht keine Internetverbindung
		echo.
		echo Beliebige Taste zum Beenden... 
		pause >nul
		exit /b 1

:: --------------------------------------------------------------------------------------------------------------------------------------------------- ::
:: ------------------------------------------   ADMINDURCHLAUF, läuft in 2.er Instanz im Hintergrund  ------------------------------------------------ ::
:: --------------------------------------------------------------------------------------------------------------------------------------------------- ::
	:Admin
		cd %WP%

		:: Rufe Installer von Strawberry und Miktex auf ::
			call :loop "%~3" "Strawberry" || goto :EoF
			start msiexec /passive /i strawberry-perl-5.30.0.1-64bit.msi

			call :loop "%~3" "Miktex" || goto :EoF
			basic-miktex-2.9.7152-x64.exe --auto-install=yes --shared --unattended
			
			echo. >done
			icacls %WP% /T /setowner %2
			icacls %WP% /T /grant %2:F
			goto :EoF

	:loop
		:: Beende, falls 1. Instanz beendet wurde, sonst warte bis Download von Strawberry/Miktex abgeschlossen ist ::
			set PID=%1
			:cloop
				tasklist /fi "PID eq %PID%" /nh /fo csv | findstr "%PID%" >nul 2>&1 || exit /b 1
				if not exist %~2 (timeout 10 /nobreak >nul &goto :cloop)
