#!/bin/bash
cd "${0%/*}"
docker-compose exec -it hive-server /bin/bash /mnt/tpcds_1g_parquet/setup.sh