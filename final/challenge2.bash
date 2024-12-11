#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <log_file> <ioc_file>"
    exit 1
fi

log_file="$1"
ioc_file="$2"
output_file="report.txt"

# Clear the output file
> "$output_file"

# Read each IOC pattern and search the log file
while IFS= read -r ioc; do
    grep "$ioc" "$log_file" | awk '{print $1, $4, $5, $7}' >> "$output_file"
done < "$ioc_file"

echo "Report has been saved to $output_file"
