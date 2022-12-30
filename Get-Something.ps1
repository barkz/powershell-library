$Foo1 = Connect-Pfa2Array -Endpoint 10.21.219.50 -Credential (Get-Credential) -IgnoreCertificateError

$arrayspace = Get-Pfa2ArraySpace

$arrayspace
