FROM 779809321836.dkr.ecr.us-east-2.amazonaws.com/amazonlinux2-python3.8

COPY build_lambda.sh /build_lambda.sh
RUN chmod +x /build_lambda.sh

RUN mkdir /application
WORKDIR /application
COPY . /application

ENTRYPOINT ["/build_lambda.sh"]
