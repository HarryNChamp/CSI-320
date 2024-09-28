Get-Content -Path "C:\xampp\apache\logs\access.log" | Select-String -Pattern ' 404 | 400 ' | Select-Object -Last 5
