. 'E:\Exchange\bin\RemoteExchange.ps1'
Connect-ExchangeServer -auto

$components = get-servercomponentstate -identity wbl1-msx-cas | where state -eq inactive | select Component
$identity = "wbl1-msx-cas"
$requester = "healthapi"
$i = 1

if ($components)
{
    #!empty
    Write-Host "Inactive exchange server components FOUND!" -ForegroundColor Red
    foreach ($component in $components) 
    {
        Write-Progress -Activity "Activating Components" -Status "Activating: $component" -PercentComplete ($i/$components.Count*100)
        set-servercomponentstate -identity $identity -component $component.ToString() -requester $requester -state active
    }
}
else
{
    #empty
    Write-Host "No inactive exchange server components!" -ForegroundColor Green
}