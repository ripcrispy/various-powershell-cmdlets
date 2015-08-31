# Remove Copies of a File

$MailTo = "" 
$MailCc = ""
$MailFrom = ""
$MailServer = ""
$MailSubject = "Removal of Assessment Reports on ${path}"
$MailBody = "The files in the attached log file have been removed from ${path}.  If the attachment is empty, no files have been found and therefore none were removed."

$logs = "\\server\share\removal_log.txt"
$path = "\\server\share\"
$rule = [regex] "appointment notification( \(\d\)| \(\d\d\)| \(\d\d\d\)).pdf"

$item = Get-ChildItem $path -recurse | ? { $_.Name -match $rule }
$item | Out-File $logs
$item | Remove-Item -recurse -force

Send-MailMessage -to $MailTo -cc $MailCc -from $MailFrom -Subject $MailSubject -Body $MailBody -smtpserver $MailServer -attachment $logs

Remove-Item -force -path $logs