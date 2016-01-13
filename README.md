# docker-dynamodb-local

A simple Dockerfile for AWS [dynamodb-local](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tools.DynamoDBLocal.html)

It's on [docker-hub](https://hub.docker.com/r/fingershock/dynamodb-local/)

[![](https://badge.imagelayers.io/fingershock/dynamodb-local:latest.svg)](https://imagelayers.io/?images=fingershock/dynamodb-local:latest 'Get your own badge on imagelayers.io')

The dockerfile is

* based on the [official docker library java8 jre](https://registry.hub.docker.com/_/java/),
* has few layers
* generates a small image (but still too large)
