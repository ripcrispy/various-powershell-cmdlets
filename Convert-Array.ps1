function Convert-Array
{
    $i = $($input)
    
    If ($($i).gettype().name -eq "String") 
    {
        $output = $i.trim().replace("`r","`n").replace("`n`n","`n").split("`n") | foreach {$_.trim()}
    } 
    Else 
    {
        $output = @()
        $i | foreach 
        {
            $output += $_
        }
    }
    return $output 
}
Set-Alias -name Out-Array -value Convert-Array
Set-alias -name oa -value convert-array