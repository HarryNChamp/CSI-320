Get-ChildItem -Path "C:\xampp\apache\logs\*.log" | ForEach-Object {
    Get-Content $_.FullName | Where-Object { $_ -match '404' } | ForEach-Object {
        if ($_ -match '\b(?:\d{1,3}\.){3}\d{1,3}\b') {
            $Matches[0]
        }
    }
} | Sort-Object -Unique