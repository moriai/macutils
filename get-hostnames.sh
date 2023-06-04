#!/usr/bin/env bash

for n in ComputerName LocalHostName HostName; do
    printf '%-15s' "$n: "
    scutil --get $n
done

echo -n "Unix HostName: "
hostname
