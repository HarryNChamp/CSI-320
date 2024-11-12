#!bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f1,4,7 | tr -d "[")
}

function pageCount(){
pagesAccessed=$(echo "$allLogs" | cut -d' ' -f3 |sort -n | uniq -c)
}

getAllLogs
pageCount
echo "$pagesAccessed"
