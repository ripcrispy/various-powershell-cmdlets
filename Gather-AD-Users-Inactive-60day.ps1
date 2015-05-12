dsquery user -limit 0 -inactive 60 > C:\test\parse.txt
Get-Content C:\test\parse.txt | select-string -pattern 'Leavers' -notmatch | select-string -pattern 'Administrative' -notmatch | Out-File C:\test\results.txt
Remove-Item C:\test\parse.txt