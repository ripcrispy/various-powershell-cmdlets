# TO-DO: set as scheduled task for each day

Add-Type @"
using System;
using System.Runtime.InteropServices;
using Microsoft.Win32;
namespace Wallpaper
{
    public class Setter 
    {
        public const int SetDesktopWallpaper = 20;
        public const int UpdateIniFile = 0x01;
        public const int SendWinIniChange = 0x02;
        [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
        private static extern int SystemParametersInfo (int uAction, int uParam, string lpvParam, int fuWinIni);
        public static void SetWallpaper (string path) 
        {
            SystemParametersInfo( SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange );
        }
    }
}
"@

$wallpapersPage = Invoke-RestMethod -Method Get -Uri "api.reddit.com/r/earthporn/"
$urls = $wallpapersPage.data.children.data.url | where { $_ -match "jpg$" }

mkdir -Force "c:\temp\reddit\"
Invoke-WebRequest -Uri $urls[0] -OutFile "c:\temp\reddit\wallpaper.jpg"

[Wallpaper.Setter]::SetWallpaper('$env:UserProfile\documents\wallpaper $(get-date -f yyyy-MM-dd).jpg')