 # Check if FIPS mode is enabled.
 Get-Item -Path 'HKLM:\System\CurrentControlSet\Control\Lsa\FIPSAlgorithmPolicy'

 # Set FIPS mode keys if not enabled.
 New-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa\FIPSAlgorithmPolicy' -Name 'Enabled' -Value "1" -PropertyType DWORD -Force
 # Check FIPS mode is enabled.
 Get-Item -Path 'HKLM:\System\CurrentControlSet\Control\Lsa\FIPSAlgorithmPolicy'
 
 # Load SDK 2.16.12.0
 # If SDK 2.16.12.0 is not installed, install from the PowerShell Gallery. Uncomment line below.
 # Install-Module -Name PureStoragePowerShellSDK2
 Import-Module -Name PureStoragePowerShellSDK2
 
 # Create a credential object. This mimics DOJ Attorney's method.
 $Creds = Get-Credential # Enter FA login creds.
 
 # OFFENDING CMDLET/COMMANDTEXT from DOJ Attorney's implementation.
 # Example cmdlet
 # Invoke-Pfa2CLICommand -EndPoint sn1-x70-e04-27.puretec.purestorage.com -Credential $Creds -CommandText "purevol list" -verbose
 #
 Invoke-Pfa2CLICommand -EndPoint <SSL Enabled Array FQDN/IP>  -Credential $Creds -CommandText "purevol list" -verbose
  
 