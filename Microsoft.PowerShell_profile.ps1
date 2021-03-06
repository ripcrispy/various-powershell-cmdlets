#Console config
$Shell = $Host.UI.RawUI
$size = $Shell.WindowSize
$size.width=100
$size.height=25
$Shell.WindowSize = $size
$size = $Shell.BufferSize
$size.width=100
$size.height=5000
$shell.BufferSize = $size
$Shell.BackgroundColor="Black"
$Shell.ForegroundColor="Green"

#Starting location
set-location C:\

#Aliases
new-item alias:np -value c:\Windows\System32\notepad.exe
new-item alias:rdp -value c:\Windows\system32\mstsc.exe

#Functions
function hist 
{ 
    Write-Host "Command History:`n" -foregroundcolor "magenta" 
    get-history -count 20 
}

function drives
{
    param ( [string]$comp = "." , [switch]$all)
    $size = @{ l = "Size (MB)"; e = { $_.size/1mb};      f = "{0:N}"}
    $free = @{ l = "free (MB)"; e = { $_.freespace/1mb}; f = "{0:N}"}
    $perc = @{ l = "Percent"; e = { 100.0 * ([double]$_.freespace/[double]$_.size)}; f="{0:f}" }
    $name = @{ e = "name"; f = "{0,-20}" }
    $fields = $name,$size,$free,$perc
    $filter = "DriveType = '3'"
    if ( $all ) { $filter = "" }
    get-wmiobject -class win32_logicaldisk -filter $filter -comp $comp | format-table $fields -auto
}

function rwip
{
    $ip = Invoke-RestMethod https://api.ipify.org?format=json | select -exp ip
    return $ip
}

function resetwifi
{
    $adapter = Get-WmiObject Win32_NetworkAdapter | Where { $_.Name.Contains("Wireless") }
    $wireless.Disable()
    Sleep(8)
    $wireless.Enable()
}

function resetlan
{
    $adapter = Get-WmiObject Win32_NetworkAdapter | Where { $_.Name.Contains("Local") }
    $wireless.Disable()
    Sleep(8)
    $wireless.Enable()
}

function wmisearch
{
    $WmiQuery = Read-Host 'Search for WMI, entering nothing results in Show All:'
    Get-WmiObject -List | Where-Object { $_.name -match $WmiQuery } | Select "Name"
}

function resyncgit
{
# TO-DO
}

function elevator
{
  $psi = new-object System.Diagnostics.ProcessStartInfo
  $psi.Verb = "runas";

  #if we pass no parameters, then launch PowerShell in the current location
  if ($args.length -eq 0)
  {
    $psi.FileName = 'powershell'
    $psi.Arguments = 
      "-NoExit -Command &{set-location '" + (get-location).Path + "'}"
  }

  #if we pass in a folder location, then launch powershell in that location
  elseif (($args.Length -eq 1) -and 
          (test-path $args[0] -pathType Container))
  {
    $psi.FileName = 'powershell'
    $psi.Arguments = 
        "-NoExit -Command &{set-location '" + (resolve-path $args[0]) + "'}"
  }

  #otherwise, launch the application specified in the arguments
  else
  {
    $file, [string]$arguments = $args;
    $psi.FileName = $file  
    $psi.Arguments = $arguments
  }
    
  [System.Diagnostics.Process]::Start($psi) | out-null
}

function Show-Intro {
    #  .---.
    # /  @  \
    # \ @ @ /
    #  {'^'}
    #     -- SQUEE!!
    write-host "  .---."  -foreground green
    write-host " /  " -foreground green -nonewline; write-host "@" -foreground red -nonewline; write-host "  \" -foreground green
    write-host " \ " -foreground green -nonewline; write-host "@ @" -foreground red -nonewline; write-host " /" -foreground green
    write-host "  {'" -foreground yellow -nonewline; write-host "^" -foreground green -nonewline; write-host "'}" -foreground yellow
    write-host "     -- SQUEE!!" -foreground white
    write-host "Matt's Powershell Profile"
    write-host "Last Update: 14/05/2015"
}

Clear-Host
cls
Show-Intro