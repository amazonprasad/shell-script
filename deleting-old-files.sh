#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
Source_dir=/tmp/muniprasad-logs

if [ ! -d $Source_dir]
then 
    echo -e " $R Source_dir: $Source_dir does not exist $N "
fi 

Files_to_delete=$(find $Source_dir -type f -mtime +14 -name "*.log")
 
while IFS= read -r line
do 
    echo -e " $G Deleting file: $line $N"
done <<< $Files_to_delete
