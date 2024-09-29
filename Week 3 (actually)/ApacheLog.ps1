
function Parse-ApacheLogs {
    param (
        [Parameter(Mandatory=$true)]
        [string]$LogFileName
    )
    $tableRecords = @()
    $logFilePath = Join-Path -Path "C:\xampp\apache\logs\" -ChildPath $LogFileName

    if (-not (Test-Path $logFilePath)) {
        Write-Error "Log file not found: $logFilePath"
        return
    }

    Get-Content $logFilePath | ForEach-Object {
        $words = $_ -split '\s+'
        if ($words[0] -match '^\d{1,3}(\.\d{1,3}){3}$') {
            $tableRecords += [PSCustomObject]@{
                IP = $words[0]
                DateTime = [DateTime]::ParseExact(($words[3] + " " + $words[4]).Trim('[]'), "dd/MMM/yyyy:HH:mm:ss zzz", $null)
                Request = $words[5..7] -join ' '
                StatusCode = $words[8]
                BytesSent = $words[9]
                UserAgent = $words[11..($words.Length-1)] -join ' '
            }
        }
    }
    return $tableRecords | Where-Object {$_.IP -like "10.*" }
}

$tableRecords = Parse-ApacheLogs -LogFileName "access.log"
$tableRecords | Format-Table -AutoSize -Wrap


