pageCount() {
    file="var/log/apache2/access.log"
    awk '{print $7} ' "$file" | sort | uniq -c | sort -nr
}
