# requires PS 5.0 for get-clipboard
Function bit-ly
{
    $token = "ENTER_BITLY_TOKEN"
    $longurl = [System.Windows.Forms.Clipboard]::GetText()
    $bitly = "https://api-ssl.bitly.com/v3/shorten?access_token=$token&longurl=$longurl"
    (Invoke-RestMethod -Uri $bitly).data.url | clip
}