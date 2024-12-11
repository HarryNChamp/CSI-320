#!/bin/bash

# Define input and output files
input_file="report.txt"
output_file="/var/www/html/report.html"

# Start the HTML file
echo "<html>" > "$output_file"
echo "<body>" >> "$output_file"
echo "<h2>Access logs with IOC indicators:</h2>" >> "$output_file"
echo "<table border='1'>" >> "$output_file"

# Read each line from the report.txt and format it as a table row
while IFS= read -r line; do
    echo "<tr><td>${line// /</td><td>}</td></tr>" >> "$output_file"
done < "$input_file"

# End the HTML file
echo "</table>" >> "$output_file"
echo "</body>" >> "$output_file"
echo "</html>" >> "$output_file"

echo "HTML report has been created at $output_file"
