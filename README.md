# deploy-django-crons

This action will package a Python 3.8 Django project into a package such that it can run in AWS Lambda. This package will include system-specific compiled binaries that some Python packages utilize.

The following Python packages require native dependencies:
* `mysqlclient` ->
* `python3-django-saml` ->
* `ldap` ->

## Inputs 
### `code`
**Required** The path to your Django root (i.e. the directory of your manage.py)
### `requirements`
**Required** The path to your pip requirements file
### `bucket`
**Required** The name of the S3 bucket you want your Lambda package uploaded to

## Example
```
uses: actions/deploy-django-crons@v1
with:
  code: 'backend'
  requirements: 'backend/requirements/common.txt'
  bucket: 'thon-post-dev-lambda'
```
