# Connect to FA using API 1.13. There are cmdlets that don't work on API 1.17. 
$FlashArray = New-PfaArray -EndPoint 10.21.201.40 -Credentials (Get-Credential) -IgnoreCertificateError -Version 1.13

# Define attributes.
# Note: A dialog or encrypted file can be used to capture the BindUser and BindPassword.
$oDS = @{
    LdapUri = "ldap://10.21.201.200"
    BaseDN = "DC=q,DC=com"
    GroupBase = "OU=PureStorageDirectoryServices"
    ArrayAdminGroup = "PureStorage_AdminGroup"
    StorageAdminGroup = "PureStorage_StorageAdminGroup"
    ReadOnlyGroup = "PureStorage_ReadOnlyGroup"
    BindUser = "Administrator"
    BindPassword = "----------"
}

# Check setup.
Get-PfaDirectoryServiceConfiguration -Array $FlashArray
Get-PfaDirectoryServiceGroups -Array $FlashArray

# Configure LDAP on FA.
Set-PfaDirectoryServiceArrayAdminGroup -Array $FlashArray -ArrayAdminGroup $oDS.ArrayAdminGroup
Set-PfaDirectoryServiceGroupBase -Array $FlashArray -GroupBase $oDS.GroupBase
Set-PfaDirectoryServiceReadOnlyGroup -Array $FlashArray -ReadOnlyGroup $oDS.ReadOnlyGroup
Set-PfaDirectoryServiceStorageAdminGroup -Array $FlashArray -StorageAdminGroup $oDS.StorageAdminGroup
Set-PfaDirectoryServiceConfiguration -Array $FlashArray -BaseDN $oDS.BaseDN -BindUser $oDS.BindUser -BindPassword $oDS.BindPassword -URI $oDS.LdapUri

# Enable and Test LDAP on FA.
Set-PfaDirectoryServiceStatus -Array $FlashArray -Enabled
Test-PfaDirectoryService -Array $FlashArray | Format-Table -Autosize