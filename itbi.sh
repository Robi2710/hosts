#!/bin/bash

validate_ip() {
    local host=$1
    local ip=$2
    local dns_server=$3

    lookup_ip=$(nslookup $host $dns_server | grep "Address" | tail -n 1 | awk '{print $2}')
    
    if [[ $ip != $lookup_ip ]]; then
        echo "Bogus IP for $host in /etc/hosts! Expected: $ip, Found: $lookup_ip"
    fi
}
cat /etc/hosts | while read -r line; do
    if [[ $line =~ ^# ]] || [[ -z $line ]]; then
        continue
    fi
        ip=$(echo $line | awk '{print $1}')
    host=$(echo $line | awk '{print $2}')
        validate_ip $host $ip 8.8.8.8
        #test
done