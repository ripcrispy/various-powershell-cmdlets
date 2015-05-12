$dist = ForEach ($group in (Get-DistributionGroup -Filter {name -like "*"})) 
{ 
	Get-DistributionGroupMember $group | Select @{Label="Group";Expression={$Group.Name}},@{Label="User";Expression{$_.Name}},SamAccountName,PrimarySmtpAddress
}
$dist | Sort Group,User | Export-CSV c:\DistGrps.csv -NoTypeInformation