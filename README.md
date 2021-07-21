# Stopped Service email notifiation script.

## Description
This script can guide an user to identify Stopped services which are set to Autostart and can send the alert as an email.

## Tasks Accomplished:
* Encrypting the SMTP server credentials.
* Bypass the security policy to run the script.
* Gathering the affected Services.
* Configuring email alert.
* Condition to generate/ not to generate email.
* Setting up a task to run the script on schedule.

## Installation:
This Scripts can be stored in a secured, defined path to run On-demand or as scheduled.

* `Config.ini`: Stores username & SecureString Password of the SMTP server.
* `PasswordEncryption.ps1` : Encrypt User password to secured format.
* `ServiceStatusAlert.ps1` : Periodic script to notifyfailed services.
* `UsingSchedulerScript.ps1` : Scheduling task on Task Scheduler.
 
 ## Usage:
 `PasswordEncryption.ps1`
* This script needs to be be executed on an elevated PowerShell terminal to encrypt the SMTP password.
* Once executed, open the output file from `C:\Scripts` and copy the output to password section of `config.ini`.
`Config.ini`

* Open this file in a text editor.
* Enter the Username manually & Password (from the above genreated script)
An Example of configuration shown below:
```
[Credentials]
Username = username@example.com
Password = SecureStringGeneratedPassword
```

`ServiceStatusAlert.ps1`
* This script contains the core logic for detecting the Autostart services and triggers an email if there are any Stopped services.
* This script needs to be configured using the task scheduler Script. `UsingSchedulerScript.ps1`
_NOTE: This script needs to be executed standalone only for testing purposes.

`UsingSchedulerScript.ps1`
* The script `User`and `password` field needs to be modified with login credentials.
* Once this script is executed, an automated task will be added to the task scheduler.
* This script is designied to executed the the service status alert.
* This task will execute immediately at 01:30 Once a day every 30 minutes.
