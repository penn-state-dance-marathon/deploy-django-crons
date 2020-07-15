FROM 779809321836.dkr.ecr.us-east-2.amazonaws.com/amazonlinux2-python3.8

# Install AWS CLI for S3 upload
RUN yum install -y unzip \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

COPY build_lambda.sh /build_lambda.sh
RUN chmod +x /build_lambda.sh

RUN mkdir /application
WORKDIR /application
COPY . /application

ENTRYPOINT ["/build_lambda.sh"]
