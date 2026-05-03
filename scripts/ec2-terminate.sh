#!/bin/bash

# Script for terminating a stopped ec2 instance by specifying its instance id

if [ ! -f .env ]; then
  echo ".env file not found!"
  exit 1
fi

set -a
source .env
set +a

INSTANCE_ID=$1

if [ -z "$INSTANCE_ID" ]; then
  echo "Usage: $0 <INSTANCE_ID>"
  exit 1
fi

echo "Terminating EC2 instance: $INSTANCE_ID..."

aws ec2 terminate-instances \
--instance-ids $INSTANCE_ID \
--region $REGION

echo "Waiting for instance to terminate..."

aws ec2 wait instance-terminated \
--instance-ids $INSTANCE_ID \
--region $REGION

echo "Instance terminated successfully."
