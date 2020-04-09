Function AddToPath {
	#.SYNOPSIS
	#Fügt einen Pfad zur Path-Variable hinzu.
	#.DESCRIPTION
	#Fügt einen Pfad zur benutzerspezifischen oder zur globalen Path-Variable hinzu.
	#.PARAMETER Pfad
	#-p, -Pfad      Pfad, der zur Path-Variable hinzugefügt werden soll.
	#.PARAMETER global
	#-g, -global    Fügt den Pfad zur globalen Path-Variable hinzu. Standardmäßig wird
	#               der Pfad zur benutzerspezifischen Path-Variable hinzu gefügt.
	#.PARAMETER force
	#-f, -force     Überspringt die Gültigkeitsüberprüfung.
   #               Der Pfad wird auch hinzugefügt, wenn dieser nicht existiert.
	#.EXAMPLE
	#C:\PS> AddToPath -Pfad 'C:\Scripts'
	#
	#Fügt den Pfad 'C:\Scripts' zur userspezifischen Path-Variable hinzu.
	#.EXAMPLE
	#C:\PS> AddToPath -Pfad 'C:\Program Files\7-Zip' -global
	#
	#Fügt den Pfad 'C:\Program Files\7-Zip' zur globalen Path-Variable hinzu.
	Param(
		[Alias('p')][string]$Pfad,
		[Alias('g')][switch]$global,
		[Alias('f')][switch]$force
		)
	
	if (! $Pfad) {Return (help AddToPath -Detailed)}
	elseif (!$force -and !(Test-Path -LiteralPath $Pfad)) {write-host -f 'red' "Der Pfad '$Pfad' konnte nicht gefunden werden.`nBenutzen Sie den '-force' Parameter, um den Pfad ohne Gülitigkeitsüberprüfung hinzuzufügen.";break}

	if ($global) {
		$Path=[environment]::GetEnvironmentVariable('Path','Machine').split(';')|?{$_}
		$Path+=$Pfad
		$Path=$Path|select -unique
		$Path="$($Path -Join ';');"
		start Powershell -WindowStyle hidden -Wait -Verb RunAs "-command [Environment]::SetEnvironmentVariable('Path','$Path','Machine')"
		}
	else {
		$Path=[environment]::GetEnvironmentVariable('Path','User').split(';')|?{$_}
		$Path+=$Pfad
		$Path=$Path|select -unique
		$Path="$($Path -Join ';');"
		[Environment]::SetEnvironmentVariable('Path',$Path,'User')
		}
	
	$Env:Path="$(($Env:Path.split(';')|?{$_}) -Join ';');$Pfad;"
	}

Function RemoveFromPath {
	#.SYNOPSIS
	#Entfernt einen Pfad aus der Path-Variable
	#.DESCRIPTION
	#Sucht in der benutzerspezifische und der globale Path-Variable nach einen Pfad und entfernt diesen.
	#Falls der Pfad in beiden Variablen existiert, wird er aus beiden entfernt.
	#.PARAMETER Pfad
	#-p, -Pfad     Pfad, der von der Path-Variable entfernt werden soll.
	#.EXAMPLE
	#C:\PS> RemoveFromPath -Pfad 'C:\Scripts'
	#
	#Entfernt den Pfad 'C:\Scripts' aus der Path-Variable.
	Param([Alias('p')][string]$Pfad)
	
	if (! $Pfad) {Return (help RemoveFromPath -Detailed)}
	
	$Global=[Environment]::GetEnvironmentVariable('Path','Machine').Split(';')|?{$_}|select -unique
	$Global=$Global|?{$Global -like $Pfad}
	$User=[Environment]::GetEnvironmentVariable('Path','User').Split(';')|?{$_}|select -unique
	$User=$User|?{$User -like $Pfad}
	
	if ($Global) {
		$Global="$(($Global|?{$_ -notlike $Pfad}) -join ';');"
		start Powershell -WindowStyle hidden -Wait -Verb RunAs "-command [Environment]::SetEnvironmentVariable('Path','$Global','Machine')"	
		}
	if ($User) {
		$User="$(($User|?{$_ -notlike $Pfad}) -join ';');"
		[Environment]::SetEnvironmentVariable('Path',$User,'User')
		}
	elseif (!$Global) {write-host -f 'red' "Der Pfad existiert in keiner Path-Variablen.";break}
	
	$Env:Path="$(($Env:path.Split(';')|?{$_ -and $_ -notlike $Pfad}) -Join ';');"
	}
