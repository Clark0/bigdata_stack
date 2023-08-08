#!/bin/bash
cd "${0%/*}"
docker-compose -f ../docker-compose.yml exec spark-hudi /spark-3.2.1-bin-hadoop3.2/bin/spark-shell
