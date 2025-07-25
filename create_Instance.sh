#!/bin/bash

AMI=ami-0b4f379183e5706b9
SG_ID=sg-01bc353182932c664
INSTANCES=("mongodb" "user" "cart" "redis" "catalogue" "shipping" "mysql" "rabbitmq" "payment" "dispatch" "web")
ZONE_ID=Z03016233H17CGAHD11OT
DOMAIN_NAME=manacars.shop
for i in "${INSTANCES[@]}"
do 
    if [ $i == "mongodb" ] || [ $i == "mysql" ] || [ $i == "shippign" ]
    then 
        INSTANCE_TYPE="t3.small"
    else
        INSTANCE_TYPE="t2.small"
    fi

    IP_ADDRESS=$(aws ec2 run-instances --image-id $AMI --instance-type $INSTANCE_TYPE --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" --query 'Instances[0].PrivateIpAddress' --output text)
    echo $i: $IP_ADDRESS

        #create R53 record, make sure you delete existing record
    aws route53 change-resource-record-sets \
    --hosted-zone-id $ZONE_ID \
    --change-batch '
    {
        "Comment": "Creating a record set for cognito endpoint"
        ,"Changes": [{
        "Action"              : "UPSERT"
        ,"ResourceRecordSet"  : {
            "Name"              : "'$i'.'$DOMAIN_NAME'"
            ,"Type"             : "A"
            ,"TTL"              : 1
            ,"ResourceRecords"  : [{
                "Value"         : "'$IP_ADDRESS'"
            }]
        }
        }]
    }
        '
done
