#region Grundeinstellungen
  using namespace System.Windows.Forms
  using namespace System.Drawing
  $ErrorActionPreference = 'Stop'
  Add-Type -A System.Windows.Forms
  [Application]::EnableVisualStyles()
  $Fonts = @(
    [Font]::New('Microsoft Sans Serif',12,[FontStyle]'Bold')
    [Font]::New('Calibri',             12,[FontStyle]'Bold, Italic')
    [Font]::New('Microsoft Sans Serif',14)
  )
#endregion Grundeinstellungen

#region Controls
  $Form  = [Form]@{Text="Zertifikat zur Codesignatur erstellen & installieren"; StartPosition='CenterScreen'
           AutoSize=$true; KeyPreview=$true; Font=$Fonts[0] ; Padding='10,10,10,10'}
  $Table = [TableLayoutPanel]@{AutoSize=$true ; Dock='Fill' ; Name="Table"}
  $Labels = @(
    [Label]@{Text="Name";                   AutoSize=$true; Margin='10,10,10,10'; Anchor='Left'; TextAlign='MiddleLeft'}
    [Label]@{Text="E-Mail";                 AutoSize=$true; Margin='10,10,10,10'; Anchor='Left'; TextAlign='MiddleLeft'}
    [Label]@{Text="Firma";                  AutoSize=$true; Margin='10,10,10,10'; Anchor='Left'; TextAlign='MiddleLeft'}
    [Label]@{Text="Ländercode (2-stellig)"; AutoSize=$true; Margin='10,10,10,10'; Anchor='Left'; TextAlign='MiddleLeft'}
    [Label]@{Text="Bundesland";             AutoSize=$true; Margin='10,10,10,10'; Anchor='Left'; TextAlign='MiddleLeft'}
    [Label]@{Text="Stadt";                  AutoSize=$true; Margin='10,10,10,10'; Anchor='Left'; TextAlign='MiddleLeft'}
    [Label]@{Text="Gültigkeit in Jahren";   AutoSize=$true; Margin='10,10,10,10'; Anchor='Left'; TextAlign='MiddleLeft'}
  )
  $Textbox = @(
    [TextBox]@{Name="CN"; Dock='Fill';   MinimumSize="150,10"; Margin='10,10,10,10'}
    [TextBox]@{Name="E";  Dock='Fill';   MinimumSize="150,10"; Margin='10,10,10,10'}
    [TextBox]@{Name="OU"; Dock='Fill';   MinimumSize="150,10"; Margin='10,10,10,10'}
    [TextBox]@{Name="C";  Anchor='Left'; Width=40; TextAlign='Center'; Margin='10,10,10,10'; Text="DE"; Tag='^[a-z]{0,2}$'}
    [TextBox]@{Name="St"; Dock='Fill';   MinimumSize="150,10"; Margin='10,10,10,10'}
    [TextBox]@{Name="L";  Dock='Fill';   MinimumSize="150,10"; Margin='10,10,10,10'}
    [TextBox]@{Name="nA"; Anchor='Left'; Width=40; TextAlign='Center'; Margin='10,10,10,10'; Text="10"; Tag='^([1-9]\d{0,1}|)$'}
  )
  $Info = @(
    [Label]@{Text="Pflichtfeld"; AutoSize=$true; Margin='10,10,10,10'; Font=$Fonts[1]; ForeColor='#C00000'; Anchor='Left'; TextAlign='MiddleLeft'}
    [Label]@{Text="Optional";    AutoSize=$true; Margin='10,10,10,10'; Font=$Fonts[1]; ForeColor='#00A000'; Anchor='Left'; TextAlign='MiddleLeft'}
    [Label]@{Text="Optional";    AutoSize=$true; Margin='10,10,10,10'; Font=$Fonts[1]; ForeColor='#00A000'; Anchor='Left'; TextAlign='MiddleLeft'}
    [Label]@{Text="Optional";    AutoSize=$true; Margin='10,10,10,10'; Font=$Fonts[1]; ForeColor='#00A000'; Anchor='Left'; TextAlign='MiddleLeft'}
    [Label]@{Text="Optional";    AutoSize=$true; Margin='10,10,10,10'; Font=$Fonts[1]; ForeColor='#00A000'; Anchor='Left'; TextAlign='MiddleLeft'}
    [Label]@{Text="Optional";    AutoSize=$true; Margin='10,10,10,10'; Font=$Fonts[1]; ForeColor='#00A000'; Anchor='Left'; TextAlign='MiddleLeft'}
    [Label]@{Text="Pflichtfeld"; AutoSize=$true; Margin='10,10,10,10'; Font=$Fonts[1]; ForeColor='#C00000'; Anchor='Left'; TextAlign='MiddleLeft'}  
  )
  $Button = [Button]@{Name='Button'; Text='Erstellen'; Size="200,50"; Anchor="Bottom"; Font=$Fonts[2]; Enabled=$false; Margin='10,10,10,10'}
#endregion Controls

#region Layout
  [void]$Table.ColumnStyles.Add([ColumnStyle]::New('AutoSize'))
  [void]$Table.ColumnStyles.Add([ColumnStyle]::New('Percent',100))
  [void]$Table.ColumnStyles.Add([ColumnStyle]::New('AutoSize'))
  Foreach ($i in 0..($Labels.Count-1)) {$Table.Controls.Add($Labels[$i],0,$i) ; $Table.Controls.Add($Textbox[$i],1,$i) ; $Table.Controls.Add($Info[$i],2,$i)};$i++
  $Table.Controls.Add($Button,0,$i)
  $Table.SetColumnSpan($Button,3)
  $Form.Controls.Add($Table)
#endregion Layout

#region Events

  # Button aktivieren/deaktivieren, falls Name und Gültigkeit gesetzt/leer sind
  $Table.Controls["CN"].Add_TextChanged({$this.Parent.Controls["Button"].Enabled = if ($this.Text -And $this.Parent.Controls["nA"].Text) {$true} else {$false}})
  $Table.Controls["nA"].Add_TextChanged({$this.Parent.Controls["Button"].Enabled = if ($this.Text -And $this.Parent.Controls["CN"].Text) {$true} else {$false}})

  # Zeichenbeschränkungen:   Ländercode = 0-2 Buchstaben   ;   Gültigkeit = Zahlen 1-99
  $Table.Controls["C","nA"].Add_KeyPress({
    $_.KeyChar = [Char]::toUpper($_.KeyChar)
    # Bei Strg+V prüfen, ob Ergebnis den Anforderungen entspricht
    if ($_.KeyChar -eq 22) {if ($this.Text.Remove($this.SelectionStart,$this.SelectionLength).Insert($this.SelectionStart,(Get-Clipboard)) -NotMatch $this.Tag) {$_.Handled=$true;break} else {break}}
    elseIf (![Char]::isControl($_.KeyChar) -and $this.Text.Remove($this.SelectionStart,$this.SelectionLength).Insert($this.SelectionStart,$_.KeyChar) -NotMatch $this.Tag) {$_.Handled=$true}
  })
  
  # Bei Button-Klick Fenster verstecken & Button-Tag auf true setzen
  $Table.Controls["Button"].Add_Click({$this.Tag=$true;$this.TopLevelControl.Hide()})
  
  # Fenstersteuerung mit Tastatur:   Escape = Abbrechen   ;   Enter = Button auslösen
  $Form.Add_KeyDown({Switch ($_.KeyCode){
    "Return" {$this.Controls["Table"].Controls["Button"].PerformClick()}
    "Escape" {$this.Hide()}
  }})
  
  $Form.Add_Load({
    $this.MaximumSize = "1920,{0}" -f $this.height
  })
#endregion Events

#region Run
  try {
    [void]$Form.ShowDialog()
    if (!$Button.Tag) {throw "Abbruch. "}
    
    $Options = @{
      Subject           = ($Table.Controls["CN","E","OU","C","St","L"]|? Text|%{"{0}={1}" -f $_.Name,$_.Text}) -Join ', '
      NotAfter          = (Get-Date).Date.AddYears($Table.Controls["nA"].Text)
      Type              = 'CodeSigningCert'
      CertStoreLocation = 'Cert:\CurrentUser\My'
    }
    Write-Host -N ("Erstelle Zertifikat für '{0}'... " -f $Table.Controls["CN"].Text)
    $Cert = New-SelfSignedCertificate @Options
    Write-Host -F green "erfolgreich. "
    
    # Wenn Administratorrechte, lege Zertifikat in 'LocalMachine' ab.
    $SL = if (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
    {'LocalMachine'} else {'CurrentUser'}
    
    $Export   = "{0}\{1}.cer" -f [Environment]::GetFolderPath('Desktop'),$Table.Controls["CN"].Text
    "{0}{1} {3}{0}`n{4}`n{0}{2} {3}{0}" -f ('-'*5),'BEGIN','END','CERTIFICATE',[convert]::ToBase64String($Cert.RawData,'i') | Set-Content -enc Default -Path $Export |Out-Null
    Write-Host -N "Installiere Zertifikat in ""Vertauenswürdige Stammzertifikate""... "
    $Root     = Get-Item "Cert:\$SL\Root"
    $Root.Open("ReadWrite")
    $Root.Add($Export)
    Write-Host -F green "erfolgreich. "
    
    Write-Host -N "Installiere Zertifikat in ""Vertauenswürdige Herausgeber""... "
    $Trusted  = Get-Item "Cert:\$SL\TrustedPublisher"
    $Trusted.Open("ReadWrite")
    $Trusted.Add($Export)
    Write-Host -F green "erfolgreich. "
    $esc = [char]27
    Write-Host ("`nIhr Zertifikat wurde erzeugt und installiert. `n`n  Fingerabdruck:          $esc[93m{0}$esc[0m `n`n  Öffentlicher Schlüssel: $esc[93;4m{1}$esc[0m `n" -f $Cert.Thumbprint,$Export)
  } catch {
    Write-Host -f red $_.Exception.Message
  } finally {
    if ($Root)    {$Root.Close()}
    if ($Trusted) {$Trusted.Close()}
  }
#endregion Run
