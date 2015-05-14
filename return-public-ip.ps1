function rwip()
{
    $ip = Invoke-RestMethod https://api.ipify.org?format=json | select -exp ip
    return $ip
    # Hello JI
}