# Encrypted Password can be created with this file.
function Get-Password {
	$credential = Get-Credential
	$credential.Password | ConvertFrom-SecureString | Set-Content C:\Scripts\Securefile.txt
}
Get-Password