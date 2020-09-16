"""
This script will run the Zappa-based lambda function with the collectstatic
and migrate Django commands. This assumes your function is named according
to the scheme <application>-<environment>
"""
import os

import boto3

APPLICATION = os.environ.get('INPUT_APPLICATION', '')
ENVIRONMENT = os.environ.get('INPUT_ENVIRONMENT', '')


def main():
    """Find the properly named function and run collectstatic and migrate"""
    client = boto3.client('lambda')
    response = client.list_functions()
    for function in response['Functions']:
        if function['FunctionName'] == f'{APPLICATION}-{ENVIRONMENT}':
            client.invoke(
                FunctionName=function['FunctionArn'],
                InvocationType='RequestResponse',
                LogType='None',
                Payload=b'{"manage": "collectstatic --noinput"}'
            )

            client.invoke(
                FunctionName=function['FunctionArn'],
                InvocationType='RequestResponse',
                LogType='None',
                Payload=b'{"manage": "migrate"}'
            )


if __name__ == '__main__':
    main()
