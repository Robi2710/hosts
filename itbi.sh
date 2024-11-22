#!/bin/bash

cat /etc/hosts | while read -r line; do
    if [[ $line =~ ^# ]] || [[ -z $line ]]; then
        continue
    fi
    ip=$(echo $line | awk '{print $1}')
    host=$(echo $line | awk '{print $2}')
    lookup_ip=$(nslookup $host | grep "Address" | tail -n 1 | awk '{print $2}')
    if [[ $ip != $lookup_ip ]]; then
        echo "Bogus IP for $host in /etc/hosts!"
    fi
done