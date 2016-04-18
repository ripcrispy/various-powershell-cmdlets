$qtVer = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall  |
    Get-ItemProperty |
        Where-Object {$_.DisplayName -match "quicktime" } |
            Select-Object -Property DisplayName, UninstallString

ForEach ($ver in $qtVer) {

    If ($ver.UninstallString) {

        $uninst = $ver.UninstallString
        $uninst = $uninst -replace "/I", "/x "
        Start-Process cmd -ArgumentList "/c $uninst /quiet /norestart" -NoNewWindow
    }
}