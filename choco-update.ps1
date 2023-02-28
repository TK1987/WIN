$Runspaces = Foreach ($dir in 'Desktop','CommonDesktop') {
  [Powershell]::Create().AddScript({
    Param([String]$Path)
    $Watcher = [System.IO.FileSystemWatcher]::New($Path,'*.lnk')
    While ($true) {
      $LNK = $Watcher.WaitForChanged('Create',1000)
      if (!$LNK.TimedOut) {rm ("{0}\{1}" -f $Path,$LNK.Name)}
    }
  }).AddParameter('Path',[Environment]::GetFolderPath($dir))
}
[void]$Runspaces.BeginInvoke()
choco upgrade --limit-output --confirm all
$Runspaces.Stop()