Import-Module PureStoragePowerShellSDK2

$arrayEndpoint = "10.21.219.50"
$FlashArray = Connect-Pfa2Array -EndPoint $arrayEndpoint -Credential (Get-Credential) -IgnoreCertificateError
$lastValidSnapshot = (Get-Pfa2ProtectionGroupSnapshot -name "hcs-cyx-pure-fa02:prodsql01v" | Sort-Object created -Descending | Select -Property name -First 1).name
$drives = Get-Pfa2VolumeSnapshot | ?{$_.name -like ("{0}*" -f $lastValidSnapshot)}
$drives | %{
    $src = New-Pfa2ReferenceObject -Id $_.Id -Name $_.Name
    New-Pfa2Volume -Name ("prodsql01v/{0}" -f $_.suffix) -Source $src -overwrite $True
}
Disconnect-Pfa2Array

