# Last Update: 04-02-2015

$emailFrom = ""
$emailTo = ""
$emailCC = ""
$emailTransportServer = ""
$emailSubject = ""

$useFile = 'C:\ReportLog.htm';
[string]$css = get-content "style.css"

# Information to be queried by Powershell, ready to be organised and placed in HTML.
$query = ""

# Just a fake example if selecting data from query.
$result = $query | Where-Object {$_."Selector" -eq "value"}

$htmlResult = $result | ConvertTo-HTML -head $css

if ($query -ne $null)
{
    $date = (Get-Date).ToShortDateString()    
    $emailBody = "$css<body>$htmlResult</body></html>"
    Send MailMessage -From $emailFrom -To $emailTo -Cc $emailCC -Subject $emailSubject -Body $emailBody -BodyasHTML -SmtpServer $emailTransportServer
    Write-Output "Request Completed: $date" | Out-File $useFile -Append
}
Else
{
    $date = (Get-Date).ToShortDateString()
    Write-Output "Request Failed: $date" | Out-File $useFile -Append    
}