#
# Dockerfile for DynamoDB Local
#
# http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tools.DynamoDBLocal.html
#
FROM java:openjdk-8-jre
MAINTAINER Bryan Talbot <bryan.talbot@ijji.com>
EXPOSE 8000
WORKDIR /dynamodb
ENV DDB_LOCAL_VERSION=2016-01-07_1.0 \
    DDB_LOCAL_SHA256=f4d8594e08f8f1edf37eefd43206677559324ef7b8c2a50436c1bf76528cf1f1
CMD ["/usr/bin/java", "-showversion", "-Djava.library.path=.", "-jar", "DynamoDBLocal.jar", "-dbPath", "/dynamodb_data"]

# VOLUME to allow persistence / access of raw database files
VOLUME ["/dynamodb_data"]

# Download and install the binaries to WORKDIR
RUN wget -q -O dynamodb_local.tar.gz http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_${DDB_LOCAL_VERSION}.tar.gz && \
    echo "${DDB_LOCAL_SHA256} dynamodb_local.tar.gz" | sha256sum -c - && \
    tar xzf dynamodb_local.tar.gz && \
    rm dynamodb_local.tar.gz
