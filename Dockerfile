#
# Dockerfile for DynamoDB Local
#
# http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tools.DynamoDBLocal.html
#
FROM java:openjdk-8-jre
MAINTAINER Bryan Talbot <bryan.talbot@playnext.com>
WORKDIR /dynamodb
EXPOSE 8000
CMD ["/usr/bin/java", "-showversion", "-Djava.library.path=.", "-jar", "DynamoDBLocal.jar", "-dbPath", "/dynamodb_data"]

# VOLUME to allow persistence / access of raw database files
VOLUME ["/dynamodb_data"]

# Download and install the binaries to WORKDIR
RUN curl -sSL http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.tar.gz | tar xzf -
