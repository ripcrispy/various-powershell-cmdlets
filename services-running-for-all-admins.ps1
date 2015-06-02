$service=Get-ADGroupMember "Domain Admins" | Get-ADUser
$domain =  DOMAIN_NAME_GOES_HERE
$Computers = Get-ADComputer -Filter "operatingsystem -like '*server*'"
foreach ($s in $service) {
    foreach ($i in $Computers) 
    {
        get-wmiobject Win32_Service -ComputerName $i.Name -ErrorAction SilentlyContinue | where-object {$_.StartName -eq "$domain\$($s.SamAccountName)" } | format-table $i.Name, Name, StartName, State
    }