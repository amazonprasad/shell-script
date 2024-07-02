#!/bin/bash

Date=$(date +%F)
Script_name=$0
Logfile=/tmp/$Script_name-$Date.log

R="\e[31m"
G="\e[32m"
N="\e[0m"


Validate(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2...$R Failure$N"
    else 
        echo -e "$2...$G Success$N"
    fi 

}
 userID=$(id -u)
 if [ $userID -ne 0 ]
 then 
    echo "Error: Please ruin this script as a root user"
else
    echo " You are the root user"
fi 

yum install java -y >> $Logfile
Validate $? "installing Java"
