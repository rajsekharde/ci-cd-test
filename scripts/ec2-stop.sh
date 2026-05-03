#!/bin/bash

# Script for stopping an active ec2 instance by specifying its instance id

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

echo "Stopping EC2 instance: $INSTANCE_ID..."

aws ec2 stop-instances \
--instance-ids $INSTANCE_ID \
--region $REGION

echo "Waiting for instance to stop..."

aws ec2 wait instance-stopped \
--instance-ids $INSTANCE_ID \
--region $REGION

echo "Instance stopped successfully."
