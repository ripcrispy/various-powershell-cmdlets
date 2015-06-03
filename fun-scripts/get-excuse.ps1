# credit goes to reddit user: /u/mehs
# thread: http://www.reddit.com/r/PowerShell/comments/2x8n3y/getexcuse/
function Get-Excuse {
    (Invoke-WebRequest http://pages.cs.wisc.edu/~ballard/bofh/excuses -OutVariable excuses).content.split([Environment]::NewLine)[(get-random $excuses.content.split([Environment]::NewLine).count)]
}