#
# Dockerfile for DynamoDB Local
#
# http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tools.DynamoDBLocal.html
#
FROM frolvlad/alpine-oraclejdk8:slim
MAINTAINER Bryan Talbot <bryan.talbot@ijji.com>
EXPOSE 8000
WORKDIR /dynamodb

ENV DDB_LOCAL_VERSION=2017-02-16 \
    DDB_LOCAL_SHA256=d79732d7cd6e4b66fbf4bb7a7fc06cb75abbbe1bbbfb3d677a24815a1465a0b2

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="Dockerfile" \
      org.label-schema.license="MIT" \
      org.label-schema.name="Docker DynamoDb-Local" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-type="git" \
      org.label-schema.vcs-url="https://github.com/iJJi/docker-dynamodb-local" \
      org.label-schema.vendor="Ijji, inc." \
      org.label-schema.version=$DDB_LOCAL_VERSION

# Download and install the binaries to WORKDIR
RUN apk add --no-cache openssl && \
    wget -q -O dynamodb_local.tar.gz https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_${DDB_LOCAL_VERSION}.tar.gz && \
    echo "${DDB_LOCAL_SHA256}  dynamodb_local.tar.gz" | sha256sum -c - && \
    tar xzf dynamodb_local.tar.gz && \
    rm dynamodb_local.tar.gz && \
    apk del openssl

RUN mkdir -p /dynamodb_data && chown nobody:nobody /dynamodb_data && chmod 0750 /dynamodb_data
USER nobody
# VOLUME to allow persistence / access of raw database files
VOLUME /dynamodb_data
ENTRYPOINT ["/usr/bin/java", "-Djava.library.path=./DynamoDBLocal_lib", "-jar", "DynamoDBLocal.jar"]
CMD ["-dbPath","/dynamodb_data"]
