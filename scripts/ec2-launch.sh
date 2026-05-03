#!/bin/bash

set -a
source .env
set +a

# Script to launch an AWS EC2 instance with parameters specified in .env file.
# Displays the Instance ID and public IPv4 address of the instance after launching.

if [ ! -f .env ]; then
  echo ".env file not found!"
  exit 1
fi

echo "Launching EC2 instance..."

INSTANCE_ID=$(aws ec2 run-instances \
--image-id $AMI_ID \
--count 1 \
--instance-type $INSTANCE_TYPE \
--key-name $KEY_NAME \
--security-group-ids $SECURITY_GROUP \
--region $REGION \
--query 'Instances[0].InstanceId' \
--output text)

echo "Instance launched: $INSTANCE_ID"

echo "Waiting for instance to be running..."
aws ec2 wait instance-running \
--instance-ids $INSTANCE_ID \
--region $REGION

echo "Fetching public IP..."

PUBLIC_IP=$(aws ec2 describe-instances \
--instance-ids $INSTANCE_ID \
--region $REGION \
--query 'Reservations[0].Instances[0].PublicIpAddress' \
--output text)

echo "==============================="
echo "Instance ID: $INSTANCE_ID"
echo "Public IP : $PUBLIC_IP"
echo "==============================="
