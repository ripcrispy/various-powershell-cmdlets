$MBs = @()  
$MBs = Get-Mailbox –ResultSize Unlimited  
$i = 1

foreach($MB in $MBs)
{
    Write-Progress -Activity "Checking..." -Status "Gathering $MB" -PercentComplete ($i/$MBs.Count*100)
    $Device = $null
    #Exchange 2010 command
    $Device = Get-ActiveSyncDevice –Mailbox $MB | ?{$_.DeviceOS –match “iOS”}
    #Exchange 2013
    #$Device = Get-MobileDevice –Mailbox $MB | ?{$_.FriendlyName –match “Outlook for iOS”}
    if ($Device –ne $null)
    {
      $Result = $MB.DisplayName + “,” + $Device.Identity + “,” + $Device.DeviceUserAgent + “,” + $Device.DeviceAccessState + “,” + $Device.DeviceAccessStateReason
      $Result | Out-File –Append “$env:UserProfile\Desktop\results.csv”
    }
}