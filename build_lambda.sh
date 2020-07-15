#!/bin/bash
# Three environment variables are needed for this script, provided by the Github action inputs
#   - INPUT_REQUIREMENTS = the filepath to your requirements file relative to your project root (e.g. requirements/common.txt)
#   - INPUT_CODE = the filepath to your manage.py file relative to project root (e.g. backend)
#   - INPUT_BUCKET = the name of the bucket you want the lambda file to live in (e.g. thon-post-dev-lambda)
# Two other environment variables are used by the Python script in the last line
#   - INPUT_APPLICATION = the value for your AWS 'Application' tags
#   - INPUT_ENVIRONMENT = the value for your AWS 'Environment' tags
pip install -r /application/$INPUT_REQUIREMENTS
mkdir /deps

# Get the Python package files and zip
cd /usr/local/lib/python3.8/site-packages
zip -r9 /lambda.zip . -x "boto*"

# Get the C extensions files and zip them
cp /usr/lib64/libxml* /deps
cp -r /usr/lib64/mysql/* /deps
cp -r /usr/lib64/libxslt* /deps
cp /usr/lib64/libltdl.so* /deps
cd /deps
zip -r9 /lambda.zip .

# Zip the application files
cd /application/$INPUT_CODE
zip -r9 /lambda.zip . -x "*/static/*" "*.git*"

# Upload to S3
aws s3 cp /lambda.zip s3://$INPUT_BUCKET/lambda.zip

# Update function code
python update_lambda_code.py
