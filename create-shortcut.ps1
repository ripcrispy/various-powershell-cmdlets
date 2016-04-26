$tar = "c:\path\to\program.exe"
$scf = "$env:Public\Desktop\program.lnk"
$ws = New-Object -ComObject WScript.Shell
$sc = $ws.CreateShortcut($scf)
$sc.TargetPath = $target
$sc.Save()