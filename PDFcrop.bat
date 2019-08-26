@echo off
setlocal enabledelayedexpansion

:: Setze Variable für Arbeitspfad ::
	set WP=%SYSTEMDRIVE%\MSiT

:: Falls als 2. Instanz gestartet gehe zu Sprungmarke :Admin, sonst starte 2. Instanz als Admin ::
	if "%~1" equ "Admin" (goto :Admin) else (start powershell start -windowstyle hidden -verb runas "%~0 Admin,%USERNAME%")

:: Erstelle Arbeitspfad ::
	mkdir %WP% 2>nul & cd %WP%

:: Downloade wget, falls es nicht existiert ::
	where wget >nul 2>&1 ||powershell wget https://github.com/TK1987/WIN/raw/master/tools/wget.exe -outfile wget.exe

:: rufe Download von Strawberry und Miktex auf ::
	:StrawMik
		call :download "Strawberry" "http://strawberryperl.com/download/5.30.0.1/strawberry-perl-5.30.0.1-64bit.msi"
		call :download "Miktex" "https://miktex.org/download/ctan/systems/win32/miktex/setup/windows-x64/basic-miktex-2.9.7152-x64.exe"

:: Erstelle Script um PDFs zuzuschneiden im Senden-An Ordner ::
	echo @echo off > "%userprofile%\AppData\Roaming\Microsoft\Windows\SendTo\PDFs zuschneiden.bat"
	echo cd %%tmp%% >> "%userprofile%\AppData\Roaming\Microsoft\Windows\SendTo\PDFs zuschneiden.bat"
	echo for %%%%a in (^%%^*) do pdfcrop %%%%a %%%%a >> "%userprofile%\AppData\Roaming\Microsoft\Windows\SendTo\PDFs zuschneiden.bat"

:: Setze Path-Variable temporär neu ::
	set ST=%systemdrive%\Strawberry
	set path=%path%%ST%\c\bin;%ST%\perl\site\bin;%ST%\perl\bin;%Programfiles%\MiKTeX 2.9\miktex\bin\x64;

:: Schließe Installation ab :: 
	cls
	echo Warte auf Ende der Installation. Fenster bitte nicht schliessen.
	:Beende
		if not exist done (timeout 10 /nobreak >nul &goto :Beende)
		cls &echo Konfiguriere PDFcrop ^& bereinige Installationsdaten.
		pdfcrop --help
		cd ..
		rd /s /q %WP%
		del "%~0"
		cls &echo Installation abgeschlossen. &echo.
		goto :EoF

:: Downloade Strawberry und Miktex ::
	:download
		for %%A in (%2) do (
			if exist %%~nxA (if not exist %~1.txt (echo. >%~1)) else (
					wget --no-check-certificate %%A
					call :download %*
					))
		goto :EoF

:: ADMINDURCHLAUF, läuft im Hintergrund in 2. Instanz ::
	:Admin
		cd %WP%

		:: Rufe Installer von Strawberry und Miktex auf ::
			call :loop "Strawberry"
			msiexec /passive /i strawberry-perl-5.30.0.1-64bit.msi

			call :loop "Miktex"
			basic-miktex-2.9.7152-x64.exe --auto-install=yes --shared --unattended
			
			echo. > done
			icacls %WP% /T /setowner %2
			icacls %WP% /T /grant %2:F
			goto :EoF

	:loop
		:: Warte bis Download von Strawberry und Miktex abgeschlossen ist ::
			if not exist %~1 (timeout 10 /nobreak >nul &goto :loop)
