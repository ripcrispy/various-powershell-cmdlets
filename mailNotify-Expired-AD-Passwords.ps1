$ErrorActionPreference = "Stop"

Function CheckPasswordAge() 
{

    $mpwage=(Get-ADDefaultDomainPasswordPolicy).MaxPasswordAge.Days

    $14days = (get-date).AddDays(14 - $mpwage)
    $7days = (get-date).AddDays(7 - $mpwage)
    $2days = (get-date).AddDays(2 - $mpwage)
    $1day = (get-date).AddDays(1 - $mpwage)

    $Accounts = Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False -and PasswordLastSet -gt 0} –Properties * | where {($_.PasswordLastSet) -le $14days} | Sort-Object PasswordLastSet

    ForEach($Account in $Accounts) 
    {
        If($Account.PasswordLastSet.Date -eq $14days.Date) 
        {
            MailNotify "in 2 weeks"
        }

        ElseIf($Account.PasswordLastSet.Date -eq $7days.Date) 
        {
            MailNotify "in 1 week"
        }

        ElseIf($Account.PasswordLastSet.Date -eq $2days.Date) 
        {
            MailNotify "in 2 days"
        }

        ElseIf($Account.PasswordLastSet.Date -eq $1day.Date) 
        {
            MailNotify "tomorrow"    
        }
    }
}

Function MailNotify([string]$TimeframeString) 
{

    $EmailBody = @"
    Hello $($Account.GivenName),<br \>
    <br \>
    This is an automated reminder to advise that your password will be expiring $($TimeframeString) 
    on $($Account.PasswordLastSet.AddDays($mpwage).Date.ToShortDateString()).<br \>
    To change your password you can press Ctrl+Alt+Del and click on: "Change your Password".<br \>
    <br \>
    <br \>
    Regards,<br \>
    Administration"
"@

    $MessageParams = @{
        To = $Account.UserPrincipalName
        SMTPServer = "Server.Domain.com"
        From = "Address@Domain.com"
        Subject = "Password Notice - Your password will expire $($TimeframeString)"
        BodyAsHtml = $true
        Body = $EmailBody
    }

    Send-MailMessage @MessageParams
        
}

CheckPasswordAge