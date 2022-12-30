%systemroot%\system32\Cscript %systemroot%\system32\scregedit.wsf /AU /v

Stop-Service -Name wuauserv
%systemroot%\system32\Cscript %systemroot%\system32\scregedit.wsf /AU 4
Start-Service -Name wuauserv

$Updates = Start-WUScan -SearchCriteria "Type='Software' AND IsInstalled=0"
$Updates
Install-WUUpdates -Updates $Updates
Get-WUIsPendingReboot
Restart-Computer -Force