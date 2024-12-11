#!/bin/bash

#URL of the IOC page
url="http://10.0.17.6/IOC-1.html"

curl -sL "$url" | \
xmlstarlet sel -t -m "//table//tr" -v "td[1]" -n > IOC.txt

echo "IOC data has been saved to IOC.txt"
