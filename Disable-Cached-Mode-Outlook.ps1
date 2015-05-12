#Outlook 2010
New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\14.0\Outlook\Cached Mode" -Force
New-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\14.0\Outlook\Cached Mode" -Name "Enable" -Value 0 -PropertyType "DWORD" -Force

#Outlook 2013
New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\Outlook\Cached Mode" -Force
New-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\Outlook\Cached Mode" -Name "Enable" -Value 0 -PropertyType "DWORD" -Force

#Switch the -Value property to 1, to re-enable.