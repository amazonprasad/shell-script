#!/bin/bash

AMI=ami-0b4f379183e5706b9
SG_ID=sg-02a430c742a1d56b7
INSTANCES=("mongodb" "user" "cart" "redis" "catalogue" "shipping" "mysql" "rabbitmq" "payment" "dispatch" "web")

for i in "${INSTANCES[@]}"
do 
    if [ $i == "mongodb" ] || [ $i == "mysql" ] || [ $i == "shippign" ]
    then 
        INSTANCE_TYPE="t3.small"
    else
        INSTANCE_TYPE="t2.small"
    fi

    IP_ADDRESS=$(aws ec2 run-instances --image-id $AMI --instance-type $INSTANCE_TYPE --security-group-ids sg-02a430c742a1d56b7 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" --query 'Instances[0].PrivateIpAddress' --output text)
    echo $i: $IP_ADDRESS
done