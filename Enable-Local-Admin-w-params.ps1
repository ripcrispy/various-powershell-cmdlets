function EnableAdmin 
{
    $NeverExpire = 65536
    $EnableUser = 512
    $objUser = [ADSI]"WinNT://$env:computername/Administrator"
    $objUser.setpassword("PASSWORD_GOES_HERE")
    $objUser.description = "Enabled Account"
    $objUser.userflags = $EnableUser + $NeverExpire
    $objUser.setinfo()
}