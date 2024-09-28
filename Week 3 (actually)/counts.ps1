$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoftens | Group-Object -Property IP | Select-Object Count, Name
$counts | Select-Object Count, Name