#!/bin/bash

date=`date -d -1days +%F`
date1=`date -d -30days +%F`

#/home/hadoop/hadoop-0.20.2-cdh3u4/bin/hadoop fs -mkdir /mysql-binlog/dsp/
/home/hadoop/hadoop-0.20.2-cdh3u4/bin/hadoop fs -rmr /mysql-binlog/dsp/wx4/$date1

cd /data/dspmysql-binlog/wx4/$date

for i in `ls |awk -F \. '{print $2}'`

do 

/usr/local/mysql/bin/mysqlbinlog mysql-bin.$i > $i
rm -f mysql-bin.$i
done

 

/home/hadoop/hadoop-0.20.2-cdh3u4/bin/hadoop fs -put /data/dspmysql-binlog/wx4/$date /mysql-binlog/dsp/wx4/$date

