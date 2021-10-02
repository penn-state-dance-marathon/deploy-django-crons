# deploy-django-crons

This action will package a Python 3.8 Django project into a package such that it can run in AWS Lambda. This package will include system-specific compiled binaries that some Python packages utilize.

The following Python packages require native dependencies:
* `mysqlclient` -> `/usr/lib64/mysql/*`
* `xmlsec` (dependency of `python3-django-saml`) -> `libxmlsec1.so.1`, `libltdl.so.7`, `libxslt.so.1`, `libxml2.so.2`, `libxmlsec1-openssl.so`
* `cairo` (dependency of `weasyprint`) -> `libcairo.so`

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
### `zappa`
**Optional (default: false)** A boolean of whether or not this is a Zappa project. If so, then this action will also run Django collectstatic and migrations on your lambda function
## Example
```
uses: penn-state-dance-marathon/deploy-django-crons@master
with:
  application: 'post'
  environment: 'dev'
  code: 'backend'
  requirements: 'backend/requirements/common.txt'
  bucket: 'thon-post-dev-lambda'
  zappa: false
```
