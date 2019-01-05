#!/bin/sh
grep -Rhio '\<v2u_\w\+\>' | sort | uniq | awk '{print length": "$0}' | sort -h
