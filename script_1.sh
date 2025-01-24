#!/bin/bash

KEY_NAME="bcitkey"
KEY_FILE="$HOME/.ssh/${KEY_NAME}"
PUB_KEY_FILE="${KEY_FILE}.pub"

if [ ! -f "${KEY_FILE}" ]; then
    echo "Generating SSH key pair..."
    ssh-keygen -t rsa -f "${KEY_FILE}" -C "aws key generated"
else
    echo "Key already exists. Using existing key."
fi

echo "Importing key to AWS..."
aws ec2 import-key-pair --key-name "${KEY_NAME}" --public-key-material fileb://"${PUB_KEY_FILE}"

if [ $? -eq 0 ]; then
    echo "Successfully imported key '${KEY_NAME}' into AWS."
else
    echo "Failed to import key. Check AWS credentials and permissions."
    exit 1
fi
