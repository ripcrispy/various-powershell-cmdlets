$Service = read-host 'Enter Account Name (DOMAIN\Username):'
$Computers = Get-ADComputer -Filter "operatingsystem -like '*server*'"
foreach ($i in $Computers) 
{get-wmiobject Win32_Service -ComputerName $i.Name -ErrorAction SilentlyContinue | where-object {$_.StartName -eq "$service" } | format-table $i.Name, Name, StartName, State}