# Use official Amazon Linux 2023 base image
FROM amazonlinux:2023

# Update packages and install Python 3.12
RUN dnf update -y && \
    dnf install -y \
        python3.12 \
        python3.12-devel \
        python3.12-pip

# Install build tools and dependencies
RUN dnf groupinstall -y "Development Tools" && \
    dnf install -y --allowerasing \
        unzip \
        wget \
        tar \
        gzip \
        openssl-devel \
        libffi-devel \
        bzip2-devel \
        zlib-devel

# Install system libraries needed by Django packages
RUN dnf install -y \
        libxml2-devel \
        libxslt-devel \
        mariadb-connector-c-devel \
        cairo-devel \
        libtool-ltdl-devel \
        libjpeg-turbo-devel \
        libpng-devel \
        libtiff-devel \
        freetype-devel

# Install xmlsec1 dependencies
RUN dnf install -y \
        xmlsec1 \
        xmlsec1-devel \
        xmlsec1-openssl \
        xmlsec1-openssl-devel || exit 1

# Create Python symlinks only (safe - won't cause zip issues)
RUN ln -sf /usr/bin/python3.12 /usr/bin/python3 && \
    ln -sf /usr/bin/python3.12 /usr/bin/python && \
    ln -sf /usr/bin/pip3.12 /usr/bin/pip3 && \
    ln -sf /usr/bin/pip3.12 /usr/bin/pip

# Install AWS CLI for S3 upload
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws


# Upgrade pip and install boto3
RUN python3 -m pip install --upgrade pip setuptools wheel && \
    python3 -m pip install boto3

COPY update_lambda_code.py /update_lambda_code.py
COPY collectstatic_and_migrate.py /collectstatic_and_migrate.py
COPY build_lambda.sh /build_lambda.sh
RUN chmod +x /build_lambda.sh

ENTRYPOINT ["/build_lambda.sh"]
