function gatherClasses() {
    $page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.25/Courses-1.html
    $trs = $page.ParsedHtml.getElementsByTagName("tr")
    
    $FullTable = @()
    for ($i = 1; $i -lt $trs.length; $i++) {
        $tds = $trs[$i].getElementsByTagName("td")
        $Times = $tds[5].innerText.Split('-')
        
        $FullTable += [PSCustomObject]@{
            "Class Code" = $tds[0].innerText.Trim()
            "Title"      = $tds[1].innerText.Trim()
            "Days"       = $tds[2].innerText.Trim()
            "Time Start" = $Times[0].Trim()
            "Time End"   = $Times[1].Trim()
            "Instructor" = $tds[6].innerText.Trim()
            "Location"   = $tds[7].innerText.Trim()
        }
    }
    return $FullTable
}

# Define the daysTranslator function
function daysTranslator($FullTable) {
    for ($i = 0; $i -lt $FullTable.length; $i++) {
        $Days = @()
        
        if ($FullTable[$i].Days -like "*M*") { $Days += "Monday" }
        if ($FullTable[$i].Days -like "*T*" -and $FullTable[$i].Days -notlike "*Th*") { $Days += "Tuesday" }
        if ($FullTable[$i].Days -like "*W*") { $Days += "Wednesday" }
        if ($FullTable[$i].Days -like "*Th*") { $Days += "Thursday" }
        if ($FullTable[$i].Days -like "*F*") { $Days += "Friday" }
        
        $FullTable[$i].Days = $Days
    }
    return $FullTable
}

# Call the functions
$classes = gatherClasses
$translatedClasses = daysTranslator($classes)

# i) List all classes of a specific instructor
$translatedClasses | Where-Object { $_.Instructor -eq "Furkan Paligu" } | Format-Table -AutoSize

# ii) List classes in a specific location on Mondays
$translatedClasses | Where-Object { $_.Location -eq "JOYC 310" -and $_.Days -contains "Monday" } |
    Sort-Object "Time Start" |
    Select-Object "Time Start", "Time End", "Class Code" |
    Format-Table -AutoSize

# iii) List unique instructors for specific courses
$Instructors = $translatedClasses | Where-Object {
    $_."Class Code" -match "SYS|NET|SEC|FOR|CSI|DAT"
} | Select-Object -Unique -Property Instructor

$Instructors | Sort-Object Instructor | Format-Table -AutoSize

# iv) Group instructors by the number of classes
$translatedClasses | Group-Object Instructor | Sort-Object Count -Descending |
    Select-Object Count, Name |
    Format-Table -AutoSize
