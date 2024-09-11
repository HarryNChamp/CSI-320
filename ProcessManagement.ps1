# Task 1: List every process for which ProcessName starts with 'C'
Write-Host "Processes starting with 'C':"
Get-Process | Where-Object { $_.ProcessName -like "C*" }

# Task 2: List every process for which the path does not include the string "system32"
Write-Host "`nProcesses not in 'system32' path:"
Get-Process | Where-Object { $_.Path -notlike "*system32*" }

# Task 3: List every stopped service, order it alphabetically, and save it to a CSV file
Write-Host "`nStopped services (saved to stopped_services.csv):"
$stoppedServices = Get-Service | Where-Object { $_.Status -eq 'Stopped' } | Sort-Object -Property DisplayName
$stoppedServices | Export-Csv -Path "C:\Path\To\Your\Directory\stopped_services.csv" -NoTypeInformation
$stoppedServices

# Task 4: Manage Google Chrome web browser
Write-Host "`nManaging Google Chrome:"
$chromeProcess = Get-Process -Name "chrome" -ErrorAction SilentlyContinue

if ($chromeProcess) {
    # If Chrome is running, stop it
    Write-Host "Stopping Google Chrome..."
    Stop-Process -Name "chrome"
} else {
    # If Chrome is not running, start it and navigate to Champlain.edu
    Write-Host "Starting Google Chrome and navigating to Champlain.edu..."
    Start-Process "chrome.exe" "https://www.champlain.edu"
}