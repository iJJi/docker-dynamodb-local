# docker-dynamodb-local

A Dockerfile for AWS [dynamodb-local](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tools.DynamoDBLocal.html) built on [alpine linux](http://www.alpinelinux.org/) so it's tiny.

It's on [docker-hub](https://hub.docker.com/r/fingershock/dynamodb-local/) and [github](https://github.com/iJJi/docker-dynamodb-local)

## tags and links
 * `latest`, `2016-04-19` [(Dockerfile)](https://github.com/iJJi/docker-dynamodb-local/blob/master/Dockerfile) [![](https://badge.imagelayers.io/fingershock/dynamodb-local:latest.svg)](https://imagelayers.io/?images=fingershock/dynamodb-local:latest) [![Build Status](https://travis-ci.org/iJJi/docker-dynamodb-local.svg?branch=master)](https://travis-ci.org/iJJi/docker-dynamodb-local)

## running

The docker entrypoint is set to run dynamodb-local with default options: the default command adds -dbPath set to /dynamodb_data.

Get list of available command line options
```
docker run --rm fingershock/dynamodb-local -help
usage: java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar
            [-port <port-no.>] [-inMemory] [-delayTransientStatuses]
            [-dbPath <path>][-sharedDb] [-cors <allow-list>]
 -cors <arg>                Enable CORS support for javascript against a
                            specific allow-list list the domains separated
                            by , use '*' for public access (default is
                            '*')
 -dbPath <path>             Specify the location of your database file.
                            Default is the current directory.
 -delayTransientStatuses    When specified, DynamoDB Local will introduce
                            delays to hold various transient table and
                            index statuses so that it simulates actual
                            service more closely. Currently works only for
                            CREATING and DELETING online index statuses.
 -help                      Display DynamoDB Local usage and options.
 -inMemory                  When specified, DynamoDB Local will run in
                            memory.
 -optimizeDbBeforeStartup   Optimize the underlying backing store database
                            tables before starting up the server
 -port <port-no.>           Specify a port number. Default is 8000
 -sharedDb                  When specified, DynamoDB Local will use a
                            single database instead of separate databases
                            for each credential and region. As a result,
                            all clients will interact with the same set of
                            tables, regardless of their region and
                            credential configuration. (Useful for
                            interacting with Local through the JS Shell in
                            addition to other SDKs)
```


Run with default configuration which persists data to a volume at /dynamodb_data. The volume can be bind-mounted to a host directory if desired.
```sh
docker run --rm -P fingershock/dynamodb-local 
```


Adding additional command line options resets the default Docker `CMD` so it must be added to keep the behavior
```sh
docker run --rm -P fingershock/dynamodb-local -dbPath /dynamodb_data -sharedDb 
```
