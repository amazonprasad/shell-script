#!/bin/bash

NAME=""
WISHES=""



while getopts ":n:w:h" opt; do
case $opt in 
    n) NAME="$OPTARG";;
    w) WISHES="$OPTARG";;
    \?) echo "Invalid options: -"$OPTARG"" >&2 ; USAGE; exit ;;
    :) USAGE; exit ;;
    h) USAGE ; exit ;;
esac 
done

if [-z "NAME"] || [-Z "WISHES"];
    echo " ERROR: Both -n and -w are mandatory options"
    USAGE 
    exit 1
fi
