$PfadA     = "C:\Tools\Einrichten\Users\AllUsers\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml"
$PfadB     = "\\xxx\SYSVOL\xxx\Scripts\Apps\Start\StartLayout.xml"
$Schlüssel = 'Registry::HKCU\Software\Policies\Microsoft\Windows\Explorer'


if (Test-Path $Schlüssel) {
  switch ((gp $Schlüssel).StartLayoutFile) {
    $PfadA {
      write-host -n "Schlüssel wird umgestellt auf '$PfadB'... "
      try {
        Set-Itemproperty -Path $Schlüssel -Name 'StartLayoutFile' -Value $PfadB -EA stop
        write-host -f green "erfolgreich."
        } catch {write-host -f red $_.Exception.Message}
      }
    $PfadB {
      write-host -n "Schlüssel wird umgestellt auf '$PfadA'... "
      try {
        Set-Itemproperty -Path $Schlüssel -Name 'StartLayoutFile' -Value $PfadA -EA stop
        write-host -f green "erfolgreich."
        } catch {write-host -f red $_.Exception.Message}
      }
    }
  }
else {
	write-host -n "Schlüssel '$Schlüssel' wird erstellt... "
	try {
		md -force $Schlüssel -EA Stop >$NULL 
		write-host -f green "erfolgreich."
		write-host -n "Pfad '$PfadB' wird zugeordnet... "
		Set-Itemproperty -Path $Schlüssel -Name 'StartLayoutFile' -Value $PfadB -EA stop
		write-host -f green "erfolgreich."
		} catch {write-host -f red $_.Exception.Message}
	}

write-host -n "`nBeliebige Taste zum Beenden... "
[void][console]::ReadKey($true)
