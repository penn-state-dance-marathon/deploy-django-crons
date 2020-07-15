# deploy-django-crons

This action will package a Python 3.8 Django project into a package such that it can run in AWS Lambda. This package will include system-specific compiled binaries that some Python packages utilize.

The following Python packages require native dependencies:
* `mysqlclient` -> `???`
* `python3-django-saml` -> `???`
* `ldap` -> `???`

## Inputs 
### `application`
**Required** The tagged application name in AWS of your Lambda functions that will be updated.
### `environment`
**Required** The tagged environment name in AWS of your Lambda functions that will be updated.
### `code`
**Required** The path to your Django root (i.e. the directory of your manage.py)
### `requirements`
**Required** The path to your pip requirements file
### `bucket`
**Required** The name of the S3 bucket you want your Lambda package uploaded to

## Example
```
uses: actions/deploy-django-crons@master
with:
  application: 'post'
  environment: 'dev'
  code: 'backend'
  requirements: 'backend/requirements/common.txt'
  bucket: 'thon-post-dev-lambda'
```
