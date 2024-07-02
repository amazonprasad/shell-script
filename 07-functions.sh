#!/bin/bash

# our program goal is to install mysqal and postfix
 Date=$(date +%F)
 Script_name=$0
 Logfile=/tmp/script_name-$Date.log

R="\e[31m"
G="\e[32m"
N="\e[0m"

# This function should validate the previous command and onform user it is success or failure

Validate(){
    # $1 it will receive the first argument 
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
    echo  "Error: Please run this script as a root user"
    exit 1
else
    echo " You are the root user"
fi

yum install mysql -y  >>$Logfile

Validate $? "installing mysql"

yum install postfix -y >>$Logfile

Validate $? "Installing Postfix"

