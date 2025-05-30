#/bin/bash

AMI=ami-0b4f379183e5706b9
SECURITY_ID=sg-02a430c742a1d56b7
INSTANCE=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" 
"dispatch" "web")
ZONE_ID=Z03833742M0KF7ERPTLO0
DOMAIN_NAME=manacars.shop

for i in "${Instances[@]}"
do 
    if [ $i == "mongodb" ] || [ $i == "mysql" ] || [ $i == "shipping" ]
    then
        INSTANCE_TYPE="t3.small"
    else
        INSTANCE_TYPE="t2.smal"
    fi
    IP_Adress=$(aws ec2 run-instances --image-id ami-0b4f379183e5706b9 --instance-type $INSTANCE_TYPE
    --security-group-ids sg-02a430c742a1d56b7 --tag-specifications "ResourseType=instance,
    Tags=[{Key=NAME,Value=$i}]" --query 'Instance[0]. PrivateIpAddres' --output text) 
done


