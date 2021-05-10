### System.Windows.Forms   [decimal]Textbox

$Textbox.Add_KeyPress({
  if (
    # Zeichen ist nicht Strg+A oder Backspace, UND...
    1,8 -NotContains [int]$_.KeyChar -and (
    
      # Zeichen ist nicht Zahl, Punkt oder Komma, ODER...
      $_.KeyChar -NotMatch '[.,\d]' -or
      
      # --- Doppelte Verwendung von Punkt/Komma ausschließen ---
      (
        $_.KeyChar         -Match    '[,.]' -and   # Zeichen ist zwar Punkt / Komma, aber
        $this.Text         -Match    '[,.]' -and   # Text enthält bereist ein solches,
        $this.SelectedText -NotMatch '[,.]'        # welches nicht selektiert ist.
      )
      
    )) {$_.Handled = $true}
})
