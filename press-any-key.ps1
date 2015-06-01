if ($Host.Name -eq "ConsoleHost")
{
    Write-Host "Press any key to continue..."
    $Host.UI.RawUI.FlushInputBuffer()   # Clear buffered input
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null
}