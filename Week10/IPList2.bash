#!/bin/bash

[ "$#" -ne 1 ] && echo "Usage: $0 <Prefix>" && exit 1

prefix=$1

[ "${#prefix}" -le 5 ] && \
printf "Prefix length is too short\nPrefix example: 10.0.17\n" && \
exit 1

for i in { 1..254} 
do
        echo "$prefic.$1"
done
