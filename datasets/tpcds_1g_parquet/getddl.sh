#!/bin/bash
rm -f tableNames.txt
rm -f HiveTableDDL.txt
hive -e "use $1; show tables;" > tableNames.txt
wait
cat tableNames.txt |while read LINE
   do
   hive -e "use $1;show create table $LINE;" >>HiveTableDDL.txt
   echo  -e "\n" >> HiveTableDDL.txt
   done
rm -f tableNames.txt
echo "Table DDL generated"