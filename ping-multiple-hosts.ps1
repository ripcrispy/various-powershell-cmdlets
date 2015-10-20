$Computers = "127.0.0.1","8.8.8.8","google.com","202.142.142.142","github.com"
$SleepTime = 0.1 #Every second
$CSVFile = "$env:UserProfile\Desktop\results.csv"

while($true)
{
    $Now = Get-Date
    $ResultObject = New-Object PSObject
    $ResultObject | Add-Member NoteProperty Time $Now
    $i = 1
    
    foreach($Computer in $Computers)
    {
        Write-Progress -Activity "Ping Test" -Status "Pinging $Computer" -PercentComplete ($i/$Computers.Count*100)
        $TestResult = Test-Connection $Computer -Count 1 -ErrorAction SilentlyContinue
        
        if($TestResult.ResponseTime -eq $null)
        {
            $ResponseTime = -1
        } else 
        {
            $ResponseTime = $TestResult.ResponseTime
        }
        
        $ResultObject | Add-Member NoteProperty $Computer $ResponseTime
        $i++
    }
    
    Write-Progress -Activity "Ping Test" -Status "Write results to file" -PercentComplete 100
    
    $ResultObject | Format-Table -AutoSize
    
    Export-Csv -InputObject $ResultObject -Path $CSVFile -Append -NoTypeInformation
    
    for($DelayTime=0; $DelayTime -lt $SleepTime; $DelayTime++)
    {
        Write-Progress -Activity "Ping Test" -Status "Sleeping" -SecondsRemaining ($SleepTime-$DelayTime)
        Start-Sleep 1
    }
}