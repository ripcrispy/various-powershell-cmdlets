. 'E:\Exchange\bin\RemoteExchange.ps1'
Connect-ExchangeServer -auto

$components = get-servercomponentstate -identity wbl1-msx-cas | where state -eq inactive | select Component
$identity = "msx-server" # input local/remote exchange server
$requester = "healthapi" # input requester
$i = 1

function sendMail($message)
{
	$passMsg = "The script executed successfully."
	$failMsg = "The script executed and there was a problem or there was nothing to resolve."
	$EmailBody = @"
    Hello,<br \>
    <br \>
    $($message)
    <br \>
    <br \>
    Regards,<br \>
    Multicomm Script"
"@

    $MessageParams = @{
        To = ""
        SMTPServer = ""
        From = ""
        Subject = ""
        BodyAsHtml = $true
        Body = $EmailBody
    }

    Send-MailMessage @MessageParams
}

if ($components)
{
    #!empty
    Write-Host "Inactive exchange server components FOUND!" -ForegroundColor Red
    foreach ($component in $components) 
    {
        Write-Progress -Activity "Activating Components" -Status "Activating: $component" -PercentComplete ($i/$components.Count*100)
        set-servercomponentstate -identity $identity -component $component.ToString() -requester $requester -state active
    }
	sendMail($passMsg)
	
}
else
{
    #empty
    Write-Host "No inactive exchange server components!" -ForegroundColor Green
	sendMail($failMsg)
}