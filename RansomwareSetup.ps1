# Set-ExecutionPolicy Unrestricted

# Install the Pure PS SDK
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-PackageProvider -Name "NuGet" 
Install-Module -Name PureStoragePowerShellSDK

## Connect to FlashArray 
$FA = New-PfaArray -Endpoint flasharray1 -Username pureuser -Password (ConvertTo-SecureString -String 'pureuser' -AsPlainText -Force) -IgnoreCertificateError

## Create Volumes
New-PfaVolume -Array $FA -VolumeName 'HR' -Unit G -Size 10
New-PfaVolume -Array $FA -VolumeName 'Production' -Unit G -Size 20
New-PfaVolume -Array $FA -VolumeName 'Sales' -Unit G -Size 30

## Connect Volumes to Host

Start-Sleep -Seconds 10
New-PfaHostVolumeConnection -Array $FA -VolumeName 'HR' -HostName 'windows1'
New-PfaHostVolumeConnection -Array $FA -VolumeName 'Production' -HostName 'windows1'
New-PfaHostVolumeConnection -Array $FA -VolumeName 'Sales' -HostName 'windows1'

## Connect Volumes to Windows iSCSI

Start-Sleep -Seconds 10
Update-IscsiTargetPortal -TargetPortalAddress 'flasharray1-iscsi'
Connect-IscsiTarget -NodeAddress 'iqn.2010-06.com.purestorage:flasharray.73e3ebb2aa0c32de'

## Initialize Disks

Start-Sleep -Seconds 10
Initialize-Disk 1 -PartitionStyle MBR -Confirm:$false
Initialize-Disk 2 -PartitionStyle MBR -Confirm:$false
Initialize-Disk 3 -PartitionStyle MBR -Confirm:$false

## Partition Disks

Start-Sleep -Seconds 10
New-Partition -DiskNumber 1 -DriveLetter d -UseMaximumSize 
New-Partition -DiskNumber 2 -DriveLetter e -UseMaximumSize 
New-Partition -DiskNumber 3 -DriveLetter f -UseMaximumSize 

## Format Disks

Start-Sleep -Seconds 10
Format-Volume -DriveLetter d -FileSystem NTFS -NewFileSystemLabel 'HR' -Confirm:$false
Start-Sleep -Seconds 3
Format-Volume -DriveLetter e -FileSystem NTFS -NewFileSystemLabel 'Production' -Confirm:$false
Start-Sleep -Seconds 3
Format-Volume -DriveLetter f -FileSystem NTFS -NewFileSystemLabel 'Sales' -Confirm:$false

## Create Folders and Files

Start-Sleep -Seconds 3
New-Item -Path 'd:\Employee Records' -ItemType Directory
New-Item -Path 'd:\Payroll' -ItemType Directory
New-Item -Path 'd:\Planning' -ItemType Directory
New-Item -Path 'd:\Micah Howser.txt' -ItemType File
New-Item -Path 'd:\Ralston Russell.txt' -ItemType File
New-Item -Path 'd:\Paul Sandoval.txt' -ItemType File
New-Item -Path 'd:\Greg Anderson.txt' -ItemType File
New-Item -Path 'd:\Juan Bullos.txt' -ItemType File
New-Item -Path 'd:\kyusko.txt' -ItemType File
New-Item -Path 'd:\ncampbell.txt' -ItemType File
New-Item -Path 'd:\jtsmith.txt' -ItemType File
New-Item -Path 'd:\dstansbury.txt' -ItemType File

New-Item -Path 'e:\SQL_Prod' -ItemType Directory
New-Item -Path 'e:\SQL-TEST' -ItemType Directory
New-Item -Path 'e:\Concentra_Apps' -ItemType Directory
New-Item -Path 'e:\Select Medical Production Data' -ItemType Directory
New-Item -Path 'e:\Email' -ItemType Directory
New-Item -Path 'e:\User_Shares' -ItemType Directory

New-Item -Path 'f:\Forecasts' -ItemType Directory
New-Item -Path 'f:\Projections' -ItemType Directory
New-Item -Path 'f:\Club 2022' -ItemType Directory

## Flush Cache in case we are too quick

Write-VolumeCache D
Write-VolumeCache E
Write-VolumeCache F
Start-Sleep -Seconds 3

## Create a Baseline Pure Snapshot for recovery

New-PfaVolumeSnapshots -Array $FA -Sources 'HR','Production','Sales' -Suffix 'BASELINE'

## Create a PGROUP with 10 min RTO 

New-PfaProtectionGroup -Array $FA -Name '10-Min-RTO'
Add-PfaVolumesToProtectionGroup -Array $FA -VolumesToAdd "hr","production","Sales" -Name "10-Min-RTO"
Set-PfaProtectionGroupSchedule -Array $FA -GroupName "10-Min-RTO" -SnapshotFrequencyInSeconds 600 
Enable-PfaSnapshotSchedule -Array $FA -Name "10-Min-RTO"
