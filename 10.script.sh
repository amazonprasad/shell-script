#!/bin/bash

Date=$(date +%F)
Srcipt_name=$0
Logdir=/home/centos/shell/script.logs
Logfile=$Logfile/$Script_name-$Date.log

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

if [$userId -ne 0 ]
then 
    echo -e "Error: please execute this script as a root user"
    exit 1
else 
    echo -e "You are the root user"
fi 

Validate(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2....$R Failure$N"
    else 
        echo -e "$2....$G Success$N"
    fi
}
for i in $@
do
    yum list installed $i &>>$Logfile
    if [$? -ne 0 ]
    then 
        echo "$i is not installed let's install it" 
        yum install $i -y &>> $Logfile
        Validate $? "$i"
    else 
        echo -e " $Y $i is already installed$N"
    fi 
done
