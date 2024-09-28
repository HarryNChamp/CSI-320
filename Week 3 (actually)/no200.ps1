Get-Content -Path "C:\xampp\apache\logs\access.log" | Where-Object { $_ -notmatch ' 200 ' } | Select-Object -Last 5
