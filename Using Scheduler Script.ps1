# Scheduling email alert for a specified time.
function ScheduleTask {
	$Action = New-ScheduledTaskAction -Execute 'pwsh.exe' -Argument '-NonInteractive -NoLogo -NoProfile -File "C:\Users\User\Desktop\ServiceStatusAlert.ps1"'
	$Trigger = New-ScheduledTaskTrigger -once -At 01:30AM
	$Settings = New-ScheduledTaskSettingsSet
	$Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Settings $Settings
	Register-ScheduledTask -TaskName 'My PowerShell Script' -InputObject $Task -User 'user' -Password 'Password'
}