#!/bin/bash
cd "${0%/*}"

TRINO_VERSION=351
if [ ! -e trino-cli.jar ]; then
    wget https://repo1.maven.org/maven2/io/trino/trino-cli/$TRINO_VERSION/trino-cli-$TRINO_VERSION-executable.jar -O trino-cli.jar
fi
java -jar trino-cli.jar --server localhost:8080 --catalog hive --schema default
