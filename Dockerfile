#
# Dockerfile for DynamoDB Local
#
# http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tools.DynamoDBLocal.html
#
FROM java:openjdk-8-jre
MAINTAINER Bryan Talbot
WORKDIR /dynamodb
EXPOSE 8000
ENV DDB_LOCAL_VERSION=2015-07-16_1.0 \
    DDB_LOCAL_SHA256=5868fd4b9f624001cda88059af7a54f412a4794dea0d3497e7c57470bfb272fa
CMD ["/usr/bin/java", "-showversion", "-Djava.library.path=.", "-jar", "DynamoDBLocal.jar", "-dbPath", "/dynamodb_data"]

# VOLUME to allow persistence / access of raw database files
VOLUME ["/dynamodb_data"]

# Download and install the binaries to WORKDIR
RUN wget -q -O dynamodb_local.tar.gz http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_${DDB_LOCAL_VERSION}.tar.gz && \
    echo "${DDB_LOCAL_SHA256} dynamodb_local.tar.gz" | sha256sum -c - && \
    tar xzf dynamodb_local.tar.gz && \
    rm dynamodb_local.tar.gz
