# Set current location. Using personal GitHub repository, https://github.com/barkz
Set-Location -Path 'C:\users\robba\OneDrive\github\powershell-library\'

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


# Import Pure Storage modules
# Import-Module -Name PureStoragePowerShellSDK
# Import-Module -Name PureStoragePowerShellSDK2 # 2.2.272.0
# Import-Module C:\Users\robba\OneDrive\Desktop\SDK2_13\PureStoragePowerShellSDK2.psd1 # 2.13
Import-Module -Name PureStoragePowerShellToolkit
#Import-Module -Name 'C:\Program Files\Pure Storage\FASSMSExtension\PureStorageBackupSDK\PureStorageBackupSDK.psd1'
Import-Module -Name Terminal-Icons
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme Paradox
Import-Module CompletionPredictor

# Disaply Pure Storage module information
Get-Module -Name *Pure* | Select-Object Name, Version, ModuleType | Format-Table -HideTableHeaders

# Set custom prompt
<# #region 
function prompt {
    $executionTime = ((Get-History)[-1].EndExecutionTime - (Get-History)[-1].StartExecutionTime).Totalmilliseconds
    $time = [math]::Round($executionTime,2)
    $execTime = ("$time ms")
    Write-Host $promptString -NoNewline -ForegroundColor cyan

    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal] $identity
    $adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator
    
    $(if (Test-Path variable:/PSDebugContext) { '[DBG]: ' }
        elseif($principal.IsInRole($adminRole)) { ($execTime).ForegroundColor.cyan + " [ADMIN]: " }
        else { '' }
    #) + 'PS ' + $(Get-Location) + $execTime + '[barkz] ' +
    ) + 'PS ' + $execTime + ' [barkz] ' +

        $(if ($NestedPromptLevel -ge 1) { '>>' }) + ' > '
}
#endregion #>

# Edit etc\hosts file
function Edit-HostsFile {
    Start-Process -FilePath notepad -ArgumentList "$env:windir\system32\drivers\etc\hosts"
}

# Edit PowerShell profile
function Edit-PowerShellProfile {
    Start-Process -FilePath "C:\Users\robba\AppData\Local\Programs\Microsoft VS Code\Code.exe" -ArgumentList "C:\Users\robba\OneDrive\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
}

# Tail a file
function tail ($file) {
    Get-Content $file -Wait
}

# Actively reload profile
function Restart-Profile {
    @(
        $Profile.AllUsersAllHosts,
        $Profile.AllUsersCurrentHost,
        $Profile.CurrentUserAllHosts,
        $Profile.CurrentUserCurrentHost
    ) | ForEach-Object {
        if(Test-Path $_) {
            Write-Verbose "Running $_"
            . $_
        }
    }    
}

#prompt