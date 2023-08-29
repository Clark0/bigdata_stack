#!/bin/bash
set -x -e

DATA_PATH="/user/hive/warehouse/tpcds_1g_parquet"

if hdfs dfs -test -e $DATA_PATH; then
    echo "$DATA_PATH exists in HDFS"
else
    hdfs dfs -mkdir -p /user/hive/warehouse
    hdfs dfs -put /mnt/tpcds_1g_parquet/source $DATA_PATH
fi

beeline -u jdbc:hive2://localhost:10000 -f /mnt/tpcds_1g_parquet/ddl.hql
