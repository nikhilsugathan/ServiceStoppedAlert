# Scheduling email alert for a specified time.
function ScheduleTask {
	$Action = New-ScheduledTaskAction -Execute 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe' -Argument '-NonInteractive -NoLogo -NoProfile -File "C:\Users\User\Desktop\WorkInProgress\ServiceStatusAlert.ps1"'
	$Trigger = New-ScheduledTaskTrigger -daily -At 01:30AM -RepetitionDuration  (New-TimeSpan -Days 1)  -RepetitionInterval  (New-TimeSpan -Minutes 30)
	$Settings = New-ScheduledTaskSettingsSet
	$Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Settings $Settings
	Register-ScheduledTask -TaskName 'Service Stopped Alerts' -InputObject $Task -User 'user' -Password 'Password'
}
ScheduleTask