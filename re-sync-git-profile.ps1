Set-ExecutionPolicy remotesigned -force
cd ([environment]::GetFolderPath([environment+SpecialFolder]::MyDocuments))
git clone git://github.com/ripcrispy/PowerShellProfile.git
exit