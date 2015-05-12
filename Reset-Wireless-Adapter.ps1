$adapter = Get-WmiObject Win32_NetworkAdapter | Where { $_.Name.Contains("Wireless") }
$wireless.Disable()
Sleep(8)
$wireless.Enable()