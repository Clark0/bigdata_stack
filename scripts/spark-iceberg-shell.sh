#!/bin/bash
cd "${0%/*}"
docker-compose -f ../docker-compose.yml --profile iceberg exec spark-iceberg /spark-3.3.0-bin-hadoop3/bin/spark-shell

