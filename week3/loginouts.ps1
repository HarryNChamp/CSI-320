. "$PSScriptRoot\EventLogsShort.ps1"

$days = 14
$loginLogoutResults = Get-LoginLogoutEvents -Days $days
$startupShutdownResults = Get-StartupShutdownEvents -Days $days

$combinedResults = @($loginLogoutResults) + @($startupShutdownResults) | Sort-Object Time

$combinedResults | Format-Table -AutoSize