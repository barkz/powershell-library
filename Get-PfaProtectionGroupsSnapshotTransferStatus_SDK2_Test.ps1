Import-Module PureStoragePowerShellSDK2
$FlashArray = Connect-Pfa2Array -Endpoint 10.21.219.60 -Credential (Get-Credential) -IgnoreCertificateError

Write-Host "Obtaining the most recent snapshot for the protection group..." -ForegroundColor Red
$MostRecentSnapshots = Get-Pfa2ProtectionGroupSnapshot -Array $FlashArray -Name 'sn1-x70r3-f04-27:foopg1' | Sort-Object created -Descending | Select -Property name -First 2
$FirstSnapStatus = Get-Pfa2ProtectionGroupSnapshotTransfer -Array $FlashArray -Name $MostRecentSnapshots[0].name 

$FirstSnapStatus

# Check that the last snapshot has been fully replicated
#$FirstSnapStatus = Get-PfaProtectionGroupSnapshotReplicationStatus -Array $FlashArray -Name $MostRecentSnapshots[0].name

# If the latest snapshot's completed property is null, then it hasn't been fully replicated - the previous snapshot is good, though
If ($FirstSnapStatus.Completed -ne $null) {
    $MostRecentSnapshot = $MostRecentSnapshots[0].name   
}
Else {
    $MostRecentSnapshot = $MostRecentSnapshots[1].name
}
$MostRecentSnapshot
#>
