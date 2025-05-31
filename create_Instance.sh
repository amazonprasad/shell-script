#!/bin/bash

AMI=ami-0b4f379183e5706b9
SECURITY_ID=sg-02a430c742a1d56b7
INSTANCES=("mongodb" "catalogue" "cart" "user" "redis" "mysql" "shipping" "rabbitmq" 
"payment" "dispatch" "web")   

for i in "${INSTANCES[@]}"
do
    if [ $i == "mongodb" ] || [ $i == "mysql" ] || [ $i == "shipping" ]
    then 
        INSTANCE_TYPE="t3.smalll"
    else
        INSTANCE_TYPE="t2.micro"
    fi

    aws ec2 run-instances --image-id ami-0b4f379183e5706b9 --instance-type $INSTANCE_TYPE
    --security-group-ids sg-02a430c742a1d56b7
done 
