$Runspaces = Foreach ($Dir in $Home,$ENV:Public) {
  [Powershell]::Create().AddScript({
    Param([String]$Path)
    $Watcher = [System.IO.FileSystemWatcher]::New($Path,'*.lnk')
    While ($true) {
      $LNK = $Watcher.WaitForChanged('Create',1000)
      if (!$LNK.TimedOut) {rm ("{0}\{1}" -f $Path,$LNK.Name)}
    }
  }).AddParameter('Path',"$Dir\Desktop")
}
[void]$Runspaces.BeginInvoke()
choco upgrade --limit-output --confirm all
$Runspaces.Stop()