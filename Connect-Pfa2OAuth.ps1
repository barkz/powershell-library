Import-Module PureStoragePowerShellSDK2

# FlashArray IP or FQDN.
$ArrayEndpoint = "10.21.219.50" 

# Unique name for this API Client.
$ArrayClientname = "foobar" 

# The name of the identity provider that will be issuing ID Tokens for this API client.
$ArrayIssuer = $ArrayClientname 

$ArrayPassword = ConvertTo-SecureString "Flash4All!" -AsPlainText -Force # is the FlashArray Password (SecureString).

# FlashArray username, local or AD user.
$ArrayUsername = "pureuser" 

# User has on the array: array_admin, storage_admin, read_only
$MaxRole = "array_admin" 

# If you created the API Client using the `New-Pfa2ArrayAuth` command there is no passphrase. 
# This password should be a SecureString. This is required if the private key was generated using a passphrase. 
$privateKeyPass = ConvertTo-SecureString "Pr1v@teK3y!#" -AsPlainText -Force 

$FlashArrayAuthObject = New-Pfa2ArrayAuth -MaxRole $MaxRole -Endpoint $ArrayEndpoint `
    -APIClientName $ArrayClientname -Issuer $ArrayIssuer -Username $ArrayUsername -Password $ArrayPassword

$FlashArrayOAuth = Connect-Pfa2Array -Endpoint $ArrayEndPoint `
    -Username $ArrayUsername `
    -Issuer $ArrayIssuer `
    -ClientId $FlashArrayAuthObject.PureClientApiClientInfo.clientId `
    -KeyId $FlashArrayAuthObject.PureClientApiClientInfo.keyId `
    -PrivateKeyFile $FlashArrayAuthObject.pureCertInfo.privateKeyFile `
    -PrivateKeyPassword $FlashArrayAuthObject.pureCertInfo.privateKeyPassphrase `
    -IgnoreCertificateError `
    -ApiClientName $ArrayClientname

$FlashArrayAuthObject