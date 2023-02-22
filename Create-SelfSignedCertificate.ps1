try {
  
  # Grundeinstellungen                                                                                                    #region
    $ErrorActionPreference = 'Stop'
    Add-Type -A System.Windows.Forms
    [Windows.Forms.Application]::EnableVisualStyles()
    $Fonts = @(
      [Drawing.Font]::New('Microsoft Sans Serif',12,[Drawing.FontStyle]'Bold')
      [Drawing.Font]::New('Calibri',             12,[Drawing.FontStyle]'Bold, Italic')
      [Drawing.Font]::New('Microsoft Sans Serif',14)
    )
  # /Grundeinstellungen                                                                                                   #endregion
  
  # Fensterelemente                                                                                                       #region
    $Form  = [Windows.Forms.Form]@{Text="Code-Signatur Zertifikat erstellen & installieren"; StartPosition='CenterScreen'
             AutoSize=$true; KeyPreview=$true; Font=$Fonts[0] ; Padding='10,10,10,10'; FormBorderStyle='FixedSingle'}
    $Table = [Windows.Forms.TableLayoutPanel]@{AutoSize=$true ; Dock='Fill' ; Name="Table"; <#CellBorderStyle='Single'#>}
    $Labels = @(
      [Windows.Forms.Label]@{Text="Name";                    AutoSize=$true; Margin='10,10,10,10'; Anchor='Left'; TextAlign='MiddleLeft'}
      [Windows.Forms.Label]@{Text="E-Mail";                  AutoSize=$true; Margin='10,10,10,10'; Anchor='Left'; TextAlign='MiddleLeft'}
      [Windows.Forms.Label]@{Text="Firma";                   AutoSize=$true; Margin='10,10,10,10'; Anchor='Left'; TextAlign='MiddleLeft'}
      [Windows.Forms.Label]@{Text="Ländercode (2-stellig)";  AutoSize=$true; Margin='10,10,10,10'; Anchor='Left'; TextAlign='MiddleLeft'}
      [Windows.Forms.Label]@{Text="Bundesland";              AutoSize=$true; Margin='10,10,10,10'; Anchor='Left'; TextAlign='MiddleLeft'}
      [Windows.Forms.Label]@{Text="Stadt";                   AutoSize=$true; Margin='10,10,10,10'; Anchor='Left'; TextAlign='MiddleLeft'}
      [Windows.Forms.Label]@{Text="Gültigkeit in Jahren";    AutoSize=$true; Margin='10,10,10,10'; Anchor='Left'; TextAlign='MiddleLeft'}
    )
    $Textbox = @(
      [Windows.Forms.TextBox]@{Name="CN"; AutoSize=$true; Anchor='Left'; Width=200; Margin='10,10,10,10'}
      [Windows.Forms.TextBox]@{Name="E";  AutoSize=$true; Anchor='Left'; Width=200; Margin='10,10,10,10'}
      [Windows.Forms.TextBox]@{Name="OU"; AutoSize=$true; Anchor='Left'; Width=200; Margin='10,10,10,10'}
      [Windows.Forms.TextBox]@{Name="C";  AutoSize=$true; Anchor='Left'; Width=40;  Margin='10,10,10,10'; Text="DE"; Tag='^[a-z]{0,2}$'}
      [Windows.Forms.TextBox]@{Name="St"; AutoSize=$true; Anchor='Left'; Width=200; Margin='10,10,10,10'}
      [Windows.Forms.TextBox]@{Name="L";  AutoSize=$true; Anchor='Left'; Width=200; Margin='10,10,10,10'}
      [Windows.Forms.TextBox]@{Name="nA"; AutoSize=$true; Anchor='Left'; Width=40;  Margin='10,10,10,10'; Text="10"; Tag='^([1-9]\d?)?$'}
    )
    $Info = @(
      [Windows.Forms.Label]@{Text="Pflichtfeld"; AutoSize=$true; Margin='10,10,10,10'; Font=$Fonts[1]; ForeColor='#C00000'; Anchor='Left'; TextAlign='MiddleLeft'}
      [Windows.Forms.Label]@{Text="Optional";    AutoSize=$true; Margin='10,10,10,10'; Font=$Fonts[1]; ForeColor='#00A000'; Anchor='Left'; TextAlign='MiddleLeft'}
      [Windows.Forms.Label]@{Text="Optional";    AutoSize=$true; Margin='10,10,10,10'; Font=$Fonts[1]; ForeColor='#00A000'; Anchor='Left'; TextAlign='MiddleLeft'}
      [Windows.Forms.Label]@{Text="Optional";    AutoSize=$true; Margin='10,10,10,10'; Font=$Fonts[1]; ForeColor='#00A000'; Anchor='Left'; TextAlign='MiddleLeft'}
      [Windows.Forms.Label]@{Text="Optional";    AutoSize=$true; Margin='10,10,10,10'; Font=$Fonts[1]; ForeColor='#00A000'; Anchor='Left'; TextAlign='MiddleLeft'}
      [Windows.Forms.Label]@{Text="Optional";    AutoSize=$true; Margin='10,10,10,10'; Font=$Fonts[1]; ForeColor='#00A000'; Anchor='Left'; TextAlign='MiddleLeft'}
      [Windows.Forms.Label]@{Text="Pflichtfeld"; AutoSize=$true; Margin='10,10,10,10'; Font=$Fonts[1]; ForeColor='#C00000'; Anchor='Left'; TextAlign='MiddleLeft'}  
    )
    $Button = [Windows.Forms.Button]@{Name='Button'; Text='Erstellen'; Size="200,50"; Anchor="Bottom"; Font=$Fonts[2]; Enabled=$false; Margin='10,10,10,10'}
  # /Fensterelemente                                                                                                      #endregion
  
  # Fensteranordnung                                                                                                      #region
    Foreach ($i in 0..($Labels.Count-1)) {$Table.Controls.Add($Labels[$i],0,$i) ; $Table.Controls.Add($Textbox[$i],1,$i) ; $Table.Controls.Add($Info[$i],2,$i)};$i++
    $Table.Controls.Add($Button,0,$i)
    $Table.SetColumnSpan($Button,3)
    $Form.Controls.Add($Table)
  # /Fensteranordnung                                                                                                     #endregion
  
  # Eventhandler                                                                                                          #region
  
    # Button aktivieren/deaktivieren, falls Name und Gültigkeit gesetzt/leer sind
    $Table.Controls["CN"].Add_TextChanged({$this.Parent.Controls["Button"].Enabled = if ($this.Text -And $this.Parent.Controls["nA"].Text) {$true} else {$false}})
    $Table.Controls["nA"].Add_TextChanged({$this.Parent.Controls["Button"].Enabled = if ($this.Text -And $this.Parent.Controls["CN"].Text) {$true} else {$false}})

    # Zeichenbeschränkungen:   Ländercode = 0-2 Buchstaben   ;   Gültigkeit = Zahlen 1-99
    $Table.Controls["C","nA"].Add_KeyPress({$_.KeyChar=([string]$_.KeyChar).ToUpper() ;Switch ($_){
      # Tasten(kombi) zulassen: Strg+A, Strg+C, Strg+X, Backspace
      {$_.KeyChar -In 1,2,24,8} {Break}
      
      # Bei Strg+V prüfen, ob Inhalt nach dem Einfügen valide ist.
      {$_.KeyChar -eq 22} {if ($this.Text.Remove($this.SelectionStart,$this.SelectionLength).Insert($this.SelectionStart,(Get-Clipboard)) -NotMatch $this.Tag) {$_.Handled=$true;break} else {break}}

      # Illegale Eingaben ignorieren
      {$this.Text.Remove($this.SelectionStart,$this.SelectionLength).Insert($this.SelectionStart,$_.KeyChar) -NotMatch $this.Tag} {$_.Handled=$true;break}
    }})
    
    # Bei Button-Klick Fenster verstecken & Button-Tag auf true setzen
    $Table.Controls["Button"].Add_Click({$this.Tag=$true;$this.TopLevelControl.Hide()})
    
    # Fenstersteuerung mit Tastatur:   Escape = Abbrechen   ;   Enter = Button auslösen
    $Form.Add_KeyDown({Switch ($_.KeyCode){
      "Return" {$this.Controls["Table"].Controls["Button"].PerformClick()}
      "Escape" {$this.Hide()}
    }})
    
  # /Eventhandler                                                                                                         #endregion
  
  # Ausführung                                                                                                            #region
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
    
	$Output   = "{0}\Desktop\{1}.cer" -f $HOME,$Table.Controls["CN"].Text
    $Export   = Export-Certificate -FilePath $Output -Cert $Cert
    Write-Host -N "Installiere Zertifikat in ""Vertauenswürdige Stammzertifikate""... "
    $Root     = Get-Item "Cert:\$SL\Root"
    $Root.Open("ReadWrite")
    $Root.Add($Export.FullName)
    Write-Host -F green "erfolgreich. "
    $Root.Close()
    
    Write-Host -N "Installiere Zertifikat in ""Vertauenswürdige Herausgeber""... "
    $Trusted  = Get-Item "Cert:\$SL\TrustedPublisher"
    $Trusted.Open("ReadWrite")
    $Trusted.Add($Export.Fullname)
    Write-Host -F green "erfolgreich. "
    rm $Export
  # /Ausführung                                                                                                           #endregion
  
} catch {

  # Fehlerbehandlung                                                                                                      #region
    Write-Host -f red $_.Exception.Message
    
    if ($Cert) {rm ("Cert:\CurrentUser\My\{0}" -f $Cert.Thumbprint)}
    if ($Export) {rm $Export}
    return
  # /Fehlerbehandlung                                                                                                     #endregion
  
}
Write-Host ("`nIhr Zertifikat wurde erzeugt und installiert. `n`n  Fingerabdruck: {0}" -F $Cert.Thumbprint)