winget source update
winget upgrade Microsoft.PowerShell
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1
winget install LGUG2Z.komorebi LGUG2Z.whkd 
# Configure komorebi and whkd
winget install Git.Git

# oh-my-posh
winget install JanDeDobbeleer.OhMyPosh --source winget
# Install NerdFonts
