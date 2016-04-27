Function writetext
{
  Param ([int]$x, [int]$y, [string]$text)
	
	[Console]::SetCursorPosition($x, $y)
	[Console]::Write($text)
}

# set background color of the shell to black
(Get-Host).UI.RawUI.BackgroundColor = "black"
clear

# player objects factory function
function newPlayer()
{
	$player = New-Object PSObject
	$player | Add-Member -type Noteproperty -Name x -Value 3
	$player | Add-Member -type Noteproperty -Name y -Value 3
	$player | Add-Member -type Noteproperty -Name char -Value "@"
	return $player
}

#create the player object
$player = newPlayer

#create the map
$width = 20
$height = 20
$map = new-Object 'object[,]' $width, $height

for($i=1; $i -le $width-1; $i++)
{	
 	for($j=1; $j -le $height-1; $j++)
	{
		$map[$i,$j] = "."
	}
}

# main loop
do
{
	[Console]::Clear()
	for($i=1; $i -le $width-1; $i++)
	{
		for($j=1; $j -le $height-1; $j++)
		{
			writetext $i $j $map[$i,$j]
		}
	}
	writetext $player.x $player.y $player.char
	$input = [Console]::ReadKey(("NoEcho"))
	if ($input.key -eq "RightArrow"){ $player.x = $player.x + 1 }
	if ($input.key -eq "LeftArrow"){ $player.x = $player.x - 1 }
	if ($input.key -eq "DownArrow"){ $player.y = $player.y + 1 }
	if ($input.key -eq "UpArrow"){ $player.y = $player.y - 1 }
} while ($input.keychar -ne "q")