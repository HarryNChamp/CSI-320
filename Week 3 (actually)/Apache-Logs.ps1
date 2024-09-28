function Get-FilteredIPs {
    param (
        [string]$PageVisited,
        [string]$HttpCode,
        [string]$Browser
    )

    $ipRegex = '\b(?:\d{1,3}\.){3}\d{1,3}\b'

    $Path = 'C:\xampp\apache\logs\'

    Get-ChildItem  -Filter *.log | 
    Select-String -Pattern $HttpCode | 
    Where-Object { $_.Line -match $PageVisited -and $_.Line -match $Browser } |
    ForEach-Object { 
        if ($_.Line -match $ipRegex) {
            [PSCustomObject]@{ "IP Address" = $matches[0] }
        }
    }
}

Get-FilteredIPs PageVisited "/index.html" -HttpCode "200" -Browser "Chrome"