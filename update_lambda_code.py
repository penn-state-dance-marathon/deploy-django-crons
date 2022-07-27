"""
This script will update the code for Lambda functions in AWS tagged according
to the input environment variables:
    "Application": INPUT_APPLICATION
    "Environment": INPUT_ENVIRONMENT
The packaged zip file will be pulled from INPUT_BUCKET/lambda.zip
"""
import os

import boto3

APPLICATION = os.environ['INPUT_APPLICATION']
ENVIRONMENT = os.environ['INPUT_ENVIRONMENT']
BUCKET = os.environ['INPUT_BUCKET']


def main():
    """Find matching tagged Lambda functions and update their code"""
    client = boto3.client('lambda')
    response = client.list_functions()
    for function in response['Functions']:
        tags = client.list_tags(Resource=function['FunctionArn'])['Tags']
        if 'Application' in tags and 'Environment' in tags and 'Functionality' in tags:
            if (tags['Application'] == APPLICATION and tags['Environment'] == ENVIRONMENT and tags['Functionality'] == 'cron'):
                response = client.update_function_code(
                    FunctionName=function['FunctionArn'],
                    S3Bucket=BUCKET,
                    S3Key='lambda.zip'
                )


if __name__ == '__main__':
    main()
