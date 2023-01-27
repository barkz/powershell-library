$FlashArray = New-PfaArray -EndPoint 0.0.0.0 -Credentials (Get-Credential) -IgnoreCertificateError

Write-Host "=================================================="
Write-Host "Pure Storage Directory Services Configuration"
Write-Host "=================================================="
Get-PfaDirectoryServiceConfiguration $FlashArray
$Groups = Get-PfaDirectoryServiceGroups -Array $FlashArray

Write-Host "=================================================="
Write-Host " Array Admins Group: $($Groups.array_admin_group)"
Write-Host "=================================================="
Get-ADGroup $Groups.array_admin_group
Get-ADGroupMember $Groups.array_admin_group

Write-Host "=================================================="
Write-Host " Read Only User Group: $($Groups.readonly_group)"
Write-Host "=================================================="
Get-ADGroup $Groups.readonly_group
Get-ADGroupMember $Groups.readonly_group

Write-Host "=================================================="
Write-Host " Storage Admin Group: $($Groups.storage_admin_group)"
Write-Host "=================================================="
Get-ADGroup $Groups.storage_admin_group
Get-ADGroupMember $Groups.storage_admin_group