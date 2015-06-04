# TO-DO: set as scheduled task for each day
$datepost = get-date -f yyyy-MM-dd

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
mkdir -Force "C:\temp\reddit\"
$wallpapersPage = Invoke-RestMethod -Method Get -Uri "api.reddit.com/r/earthporn/"
$urls = $wallpapersPage.data.children.data.url | where { $_ -match "jpg$" }

Invoke-WebRequest -Uri $urls[0] -OutFile "C:\temp\reddit\wallpaper $datepost.jpg"

[Wallpaper.Setter]::SetWallpaper('C:\temp\reddit\wallpaper $datepost.jpg')