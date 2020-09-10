# Neuste Excelversion finden
$ExcelPfad = (ls -r "$Env:Systemdrive\Program Files*\Microsoft Office\Excel.exe"|sort -d Directory|select -First 1).Fullname

# Kontextmenüeinträge erstellen
'.xls','.xlsx' | % {
  $Keyname = (gp "Registry::HKCR\$_" -EA si).'(default)'
  if ($Keyname) {try {
    write-host -n "Erstelle Kontextmenüeinträge für '$_'... "
    md -Force              "Registry::HKCU\Software\Classes\$Keyname\shell\Excel\command"                    >$NULL -EA stop
    md -Force              "Registry::HKCU\Software\Classes\$Keyname\shell\Excel (schreibgeschützt)\command" >$NULL -EA stop
    Set-Itemproperty -Path "Registry::HKCU\Software\Classes\$Keyname\shell\Excel\command"                    -Name '(default)' -Value """$ExcelPfad"" ""%1"""    -EA stop
    Set-Itemproperty -Path "Registry::HKCU\Software\Classes\$Keyname\shell\Excel (schreibgeschützt)\command" -Name '(default)' -Value """$ExcelPfad"" /r ""%1""" -EA stop
    Set-Itemproperty -Path "Registry::HKCU\Software\Classes\$Keyname\shell\Excel"                            -Name 'Icon'      -Value """$ExcelPfad"""           -EA stop
    Set-Itemproperty -Path "Registry::HKCU\Software\Classes\$Keyname\shell\Excel (schreibgeschützt)"         -Name 'Icon'      -Value """$ExcelPfad"""           -EA stop
    write-host -f green "erfolgreich. "
    } catch {write-host -f red $_.Exception.Message}}
  }
