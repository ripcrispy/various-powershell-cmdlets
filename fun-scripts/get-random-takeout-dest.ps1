# random take-out

$response = 'Y'
$takeOut = $null
$takeOutList = @()
$WriteOutList = $null
$Choice = $null

Do
{
    $takeOut = Read-Host 'Please enter a take-out destination'
    $response = Read-Host 'Would you like to add an additional choice? (y/n) default: y'
    $takeOutList += $takeOut
}
until ($response -eq 'n')

$Choice = Get-Random $takeOutList

Write-Host "$Choice" -ForegroundColor Yellow