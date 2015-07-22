Get-ADComputer -filter {name -like <computerName filter>} | Move-ADObject -TargetPath 'OU=<lowLevelOU>,OU=<ou>,OU=<topLevelOU>,DC=<lowLevelDomain>,DC=<domain>,DC=<topLevelDomain>'