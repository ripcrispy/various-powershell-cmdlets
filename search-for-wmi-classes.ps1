$WmiQuery = Read-Host 'Search for WMI, entering nothing results in Show All:'
Get-WmiObject -List | Where-Object { $_.name -match $WmiQuery } | Select "Name"