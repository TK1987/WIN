Begin {
  $ColorN = @{ F='White' ; B='DarkMagenta' }
  $ColorC = @{ F='Black' ; B='White' }
  $Printers = Get-WmiObject Win32_Printer
  $i = $Printers.Default.IndexOf($true)
  $c = [char]16
}
Process { while ($true) {
  cls
  [Console]::CursorVisible = $false
  $Width = [Console]::WindowWidth
  write-host "".PadRight($width,[char]22)
  write-host " Standarddrucker wählen "
  write-host ("".PadRight($width,[char]22)+"`n")
  
  Foreach ($Printer in $Printers) {write-host @ColorN " $c $($Printer.Name.PadRight($width-3,' '))"}
  write-host -n ("`n".PadRight($width+1,[char]22)+" ")
  write-host -n @ColorC "[Esc]"
  Write-host -n @ColorN " Abbruch     "
  write-host -n @ColorC "[Enter]"
  write-host @ColotN " Bestätigen"
  write-host "".PadRight($width,[char]22)
  [Console]::CursorTop = $i+4
  write-host -n @ColorC "`r $c $($Printers[$i].Name.Padright($Width-3,' '))"
  
  while ([Console]::WindowWidth -eq $Width) { switch ([Console]::ReadKey($true).Key) {
    'UpArrow' {
      write-host -n @ColorN "`r $c $($Printers[$i].Name.Padright($Width-3,' '))"
      if ($i -eq 0){$i = $Printers.Count-1} else {$i--}
      [Console]::CursorTop = $i+4
      write-host -n @ColorC "`r $c $($Printers[$i].Name.Padright($Width-3,' '))"
    }
    'DownArrow' {
      write-host -n @ColorN "`r $c $($Printers[$i].Name.Padright($width-3,' '))"
      if ($i -eq ($Printers.Count-1)){$i = 0} else {$i++}
      [Console]::CursorTop = $i+4
      write-host -n @ColorC "`r $c $($Printers[$i].Name.Padright($width-3,' '))"
    }
    'Enter'  {
      cls
      [void]$Printers[$i].SetDefaultPrinter()
      write-host "'$($Printers[$i].Name)' ist jetzt der Standarddrucker. "
      Return
      }
    'Escape' {cls ; Return}
  }}
}}
End { [Console]::CursorVisible = $true }
