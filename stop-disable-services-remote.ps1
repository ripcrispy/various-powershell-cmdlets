[cmdletbinding()]            
param(            
    [string[]]$ComputerName = $env:ComputerName,            
    [parameter(Mandatory=$true)]            
    [string[]]$ServiceName            
)            
            
foreach($Computer in $ComputerName)
{            
    Write-Host "Working on $Computer"            
    
    if(!(Test-Connection -ComputerName $Computer -Count 1 -quiet))
    {            
        Write-Warning "$computer : Offline"            
        Continue            
    }            

    foreach($service in $ServiceName)
    {            
        try 
        {            
            $ServiceObject = Get-WMIObject -Class Win32_Service -ComputerName $Computer -Filter "Name='$service'" -EA Stop            
            
            if(!$ServiceObject) 
            {            
                Write-Warning "$Computer : No service found with the name $service"            
                Continue            
            }            
            
            if($ServiceObject.StartMode -eq "Disabled") 
            {            
                Write-Warning "$Computer : Service with the name $service already in disabled state"            
                Continue            
            }            
            
            Set-Service -ComputerName $Computer -Name $service -EA Stop -StartMode Disabled            
            Write-Host "$Computer : Successfully disabled the service $service. Trying to stop it"            
            
            if($ServiceObject.Status -eq "Running")
            {            
                Write-Warning "$Computer : $service already in stopped state"            
                Continue            
            }            
            
            $retval = $ServiceObject.StopService()            
            
            if($retval.ReturnValue -ne 0)
            {            
                Write-Warning "$Computer : Failed to stop service. Return value is $($retval.ReturnValue)"            
                Continue            
            }            
               
            Write-Host "$Computer : Stopped service successfully"            
               
        } catch 
        {            
            Write-Warning "$computer : Failed to query $service. Details : $_"            
            Continue            
        }            
    }            
}