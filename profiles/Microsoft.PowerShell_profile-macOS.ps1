# Header
Write-Host
Write-Host '          /++++++++++++++\' 
Write-Host '         /++++++++++++++++\'
Write-Host '        /++++++++++++++++++\'
Write-Host '       /++++++++++++++++++++\'
Write-Host '      /++++++/        \++++++\'
Write-Host '     /++++++/          \++++++\'
Write-Host '     \++++++\          /++++++/'
Write-Host '      \++++++\        /++++++/'
Write-Host '       \++++++\'
Write-Host '        \++++++\'
Write-Host '         \++++++\'

# Load modules
Import-Module -Name PureStoragePowerShellSDK2
Import-Module -Name PureStoragePowerShellSDK
Import-Module -Name PureStoragePowerShellToolkit

# Disaply Pure Storage module information
Get-Module -Name *Pure* | Select-Object Name, Version, ModuleType | Format-Table -HideTableHeaders

# Set SDK working directory variable
$SDK = "/Users/barkz/.local/share/powershell/Modules/"
