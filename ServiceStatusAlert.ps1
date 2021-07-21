## When this script is run, it iterates through the list of services which are set to automatic but currently not
## in a running state. Then it attempts to email the list of not running services to a given notification emai.
##
## TODO
## Error handling
## Transfer the script to Git Repro

# List of services set to auto-start, which are not in a running state

# To bypass the secuity policy when testing locally.
Set-ExecutionPolicy Bypass

# To fetch the stopped servies which are set to Autostart.
function Get-StoppedServices {
	Get-Service | Select-Object -Property DisplayName,Name,Status,StartType | where starttype -match Automatic | where status -match Stopped | Out-String
}

# Configure and send output over email to the recipient.
function Send-Email($ServiceStatus) {
	$emailusername = "xxx@gmail.com"
	$encrypted = Get-Content C:\Users\User\Desktop\Common.txt | ConvertTo-SecureString
	$credential = New-Object System.Management.Automation.PsCredential($emailusername, $encrypted)
	$FromAddress = "xxx@gmail.com"
	$ToAddress = "xxx@outlook.com" # This email address can be changed to alerts@mydomain.com.
	$MessageSubject = "Service Stopped"
	$MessageBody = "The below service(s) stopped running, please investigate immediately"
	$MessageBody = $MessageBody + $ServiceStatus
	$SMTPServer = "smtp.gmail.com"
	$SMTPMessage = New-Object System.Net.Mail.MailMessage($FromAddress,$ToAddress,$MessageSubject,$MessageBody)
	$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587) 
	$SMTPClient.Credentials = $credential;
	$SMTPClient.EnableSsl = $true
	$SMTPClient.Send($SMTPMessage)
}

# Send an email notification after checking service status.
function Notify-FailedServices {
	$ServiceStatus = Get-StoppedServices
	Write-Output $ServiceStatus
	
	if ($ServiceStatus.Split("\n").Length -gt 1)
	{ 
		Write-Output "Sending email"
		#Send email
		Send-Email($ServiceStatus)
	}
	else
	{
		Write-Output "No automatic service in Stopped state."
	}
}

# Entry point for execution
Notify-FailedServices