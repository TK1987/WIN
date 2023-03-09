# GUI-Modul Laden
  Add-Type -a System.Windows.Forms
  
# Settings
  [Windows.Forms.Application]::EnableVisualStyles()
  $Format = @(
    "*.jpg"
    "*.bmp"
    "*.png"
    "*.tif"
    "*.tiff"
    "*.gif"
  )
  $Font = @(
    [Drawing.Font]::New("Microsoft Sans Serif",12)
  )
  $Invalid = [io.path]::InvalidPathChars.ForEach({[regex]::Escape($_)}) -Join '|'

# Fensterelemente
  $Form  = [Windows.Forms.Form]@{StartPosition='CenterScreen'; AutoSize=$true; Padding='10,10,10,10'; Size='100,100'; Text="Img2Dir p.a."; Font=$Font[0]; KeyPreview=$true; FormBorderStyle='FixedSingle'}
  $Table = [Windows.Forms.TableLayoutPanel]@{Dock='Fill'; AutoSize=$true}
  $FlowPanel = [Windows.Forms.FlowLayoutPanel]@{AutoSize=$true; Anchor='Top'; Name="FP"}
  $dir_Button = @(
    [Windows.Forms.Button]@{Text="Öffnen";    Name='open'; Size='100,35'; Margin='10,10,10,10'}
    [Windows.Forms.Button]@{Text="Speichern"; Name='spen'; Size='100,35'; Margin='10,10,10,10'}
  )
  $dir_Button.Foreach({Add-Member -inp $_ NoteProperty FB_Dialog ([Windows.Forms.FolderBrowserDialog]@{RootFolder="MyComputer"})})
  $Textbox = @(
    [Windows.Forms.Textbox]@{Name='otb'; Size='300,25'; Margin='0,10,10,10'; Anchor='Left'; Tag=$false}
    [Windows.Forms.Textbox]@{Name='stb'; Size='300,25'; Margin='0,10,10,10'; Anchor='Left'; Tag=$false}
  )
  $Checkbox = @(
    [Windows.Forms.Checkbox]@{Checked=$true; Margin="20,10,10, 5"; Name='Recurse';  Text="Unterordner einbeziehen";                AutoSize=$true}
    [Windows.Forms.Checkbox]@{Checked=$true; Margin="20, 5,10,10"; Name='DelEmpty'; Text="Leere Unterordner anschließend löschen"; AutoSize=$true}
  )
  $Crtl_Button = @(
    [Windows.Forms.Button]@{Text="Abbruch";   Name='cancel'; Size='100,40'; Margin='10,10,10,10'}
    [Windows.Forms.Button]@{Text="Ausführen"; Name='run'   ; Size='100,40'; Margin='10,10,10,10'; Enabled=$false}
  )
  
# Eventhandler

  # Bei Klick auf öffnen/speichern-Button, Ordnerauswahl anzeigen. Selektierten Pfad zur Textbox hinzufügen.
  $dir_Button.Add_Click({
    if ($this.FB_Dialog.ShowDialog() -eq "ok"){
      $this.Parent.Controls[($this.Name[0]+'tb')].Text = $this.FB_Dialog.SelectedPath
    }
  })
  
  # Wenn in beiden Textboxen ein gültiger Pfad steht, Ausführen-Button aktivieren
  $Textbox.Add_TextChanged({
    if ($this.Text -and (Test-Path -EA SilentlyContinue ($this.Text -Replace $Invalid))) {
      $this.Tag = $true
    } else {$this.Tag=$false}
    if ($this.Parent.Controls["otb","stb"].Tag -NotContains $false) {$this.Parent.Controls["FP"].Controls["run"].Enabled=$true}
    else {$this.Parent.Controls["FP"].Controls["run"].Enabled=$false}
  })
  
  # Bei Fensterstart, Settings laden und einsetzen
  $Form.Add_Load({
    if (Test-Path "HKCU:\Software\Img2Dir-pa") {
      $Settings = gp "HKCU:\Software\Img2Dir-pa"
      $this.Controls[0].Controls["otb"].Text = $Settings.Open
      $this.Controls[0].Controls["stb"].Text = $Settings.Save
      $this.Controls[0].Controls["Recurse"].Checked  = $Settings.Recurse
      $this.Controls[0].Controls["DelEmpty"].Checked = $Settings.DelEmpty
      
    } else {[void](ni -force "HKCU:\Software\Img2Dir-pa")}
  })
  
  # Bei Klick auf Kontrollbuttons, Buttonname als Fenstertag setzen und Fenster beenden
  $Crtl_Button.Add_Click({
    $this.TopLevelControl.Tag = $this.Name
    $this.TopLevelControl.Hide()
  })
  
  # Tastatursteuerung: Enter=Ausführen, Escape=Abbrechen
  $Form.Add_KeyDown({
    switch ($_.KeyCode) {
      "Enter"  {$this.Controls[0].Controls["FP"].Controls["run"].PerformClick()}
      "Escape" {$this.Controls[0].Controls["FP"].Controls["cancel"].PerformClick()}
    }
  })
  
  # Wenn Recurse-Checkbox false, DelEmpty-Checkbox deaktivieren
  $Checkbox[0].Add_CheckStateChanged({
    $this.Parent.Controls["DelEmpty"].Enabled = $this.Checked
  })

  # Beim Verlassen der Textboxen, ungültige Zeichen entfernen
  $Textbox.Add_Leave({$this.Text = $this.Text -Replace $Invalid})

# Fenster zusammenfügen
  $i=0;Foreach ($Button in $dir_Button) {$Table.Controls.Add($dir_Button[$i],0,$i); $Table.Controls.Add($Textbox[$i],1,$i); $i++}
  Foreach ($CB in $Checkbox) {$Table.Controls.Add($CB,0,$i); $Table.SetColumnSpan($CB,2); $i++}
  $FlowPanel.Controls.AddRange($crtl_Button)
  $Table.Controls.Add($FlowPanel,0,$i);$i++
  $Table.SetColumnSpan($FlowPanel,2)
  $Form.Controls.Add($Table)
  
# Ausführung
  
  # Bei Fehlern, springe in Catch-Block
  $ErrorActionPreference = 'Stop'
  try {
    [void]$Form.ShowDialog()
    switch ($Form.Tag) {
      "run" {
        $Settings = @{
          Open     = $Form.Controls[0].Controls["otb"].Text
          Save     = $Form.Controls[0].Controls["stb"].Text
          Recurse  = [int]$Form.Controls[0].Controls["recurse"].Checked
          DelEmpty = [int]$Form.Controls[0].Controls["DelEmpty"].Checked
        }
        [void](New-ItemProperty -Force "HKCU:\Software\Img2Dir-pa" "open"     -Value $Settings.Open)
        [void](New-ItemProperty -Force "HKCU:\Software\Img2Dir-pa" "save"     -Value $Settings.Save)
        [void](New-ItemProperty -Force "HKCU:\Software\Img2Dir-pa" "Recurse"  -Value ([int]$Settings.Recurse))
        [void](New-ItemProperty -Force "HKCU:\Software\Img2Dir-pa" "DelEmpty" -Value ([int]$Settings.DelEmpty))
        $Options = @{Recurse=$Settings.Recurse}
        $Files = Get-ChildItem @Options "$($Settings.Open)\*" -Include $Format
        Foreach ($FG in $Files |Group {$Settings.Save+'\'+$_.LastWriteTime.Year}) {
          if (!(Test-Path -PathType Container $FG.Name)) {
            Write-Host -N ("Erstelle Ordner: {0,-54}" -f $FG.Name)
            [void](md $FG.Name -Force)
            Write-Host -f Green "[ok]"
          } else {Write-Host ('Ordner existiert: {0} ' -f $FG.Name)}
          Foreach ($File in $FG.Group) {
            Write-Host -N ('     └-->   {0,-58} ' -f $File.Name)
            move -Force -Path $File -Destination $FG.Name
            Write-Host -F green "[ok]"
          }
          ""
        }
        if ($Settings.Recurse -and $Settings.DelEmpty) {
          $dirs = Get-ChildItem -Recurse -Directory $Settings.Open
          Foreach ($dir in $dirs.Fullname|sort -Descending) {
            if (!(Get-ChildItem -Recurse "S:\open\*" -Force -Exclude "Thumbs.db")) {
              Write-Host -N ("Lösche Ordner: {0,-54}" -f $dir)
              Remove-Item -Recurse $dir -Force
              Write-Host -F green "[ok]"
            }
          }
        }
      }
      "cancel" {Return}
    }
  }
  # Bei Fehlern, Fehlerlog erzeugen und schließen
  catch {
    Write-Host -f red $_.Exception.Message
  }
