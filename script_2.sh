#!/usr/bin/env bash

# Check if the number of command-line arguments is correct
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <bucket_name>"
    exit 1
fi

# pass the bucket name as a positional parameter 
bucket_name=$1

# Region
region="us-west-2"

# Check if the bucket exists
if aws s3api head-bucket --bucket "$bucket_name" 2>/dev/null; then
    	echo "Bucket $bucket_name already exists."
else
  	# change the line below
  	echo $bucket_name
  
  	# Create Bucket
  	echo "Creating $bucket_name in region $region"
	aws s3api create-bucket --bucket "$bucket_name" \
        --region "$region" \
        --create-bucket-configuration LocationConstraint=$region \

	if [ $? -eq 0 ]; then
		echo "Bucket $bucket_name Created"
	else
		echo "Failed to create $bucket_name"
		exit 1
	fi

fi

