#!/bin/bash

 [ "$#" -ne 1 ] && echo "Usage: $0 <Prefix>" && exit 1
 2
 3 prefix=$1
 4
 5 for i in {1..254}
 6 do
 7         echo "$prefix.$1"
 8 done
 9




