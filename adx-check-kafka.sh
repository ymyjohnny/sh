#!/bin/bash

date=`date +%F-%H:%M:%S`
export JAVA_HOME=/usr/local/java/
export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH


statistics=`/home/algorithm/kafka-0.8.0-src/bin/kafka-run-class.sh kafka.tools.ConsumerOffsetChecker --zkconnect 192.168.32.38:2181 --group adx-statistics-group --topic=adx-statistics-topic  | awk '{print $6}'|tail -4|awk '{sum += $1} END{print sum}'`

audit=`/home/algorithm/kafka-0.8.0-src/bin/kafka-run-class.sh kafka.tools.ConsumerOffsetChecker --zkconnect 192.168.32.38:2181 --group adx-audit-group --topic=adx-audit-topic | awk 'BEGIN{sum=0}{sum+=$6}END{print sum}'`

censor=`/home/algorithm/kafka-0.8.0-src/bin/kafka-run-class.sh kafka.tools.ConsumerOffsetChecker --zkconnect 192.168.32.38:2181 --group adx-censor-group --topic=adx-censor-topic | awk 'BEGIN{sum=0}{sum+=$6}END{print sum}'`

echo "statistics:$statistics" > /tmp/statistics
echo "audit:$audit" > /tmp/audit
echo "censor:$censor" > /tmp/censor

if [ $statistics -lt 2999 ];then
   echo ok
else
  cat /tmp/statistics |mail -s "$date.statistics" ymyjohnny@adsame.com scott_gao@adsame.com arthur_wang@adsame.com alex_zheng@adsame.com

fi

if [ $audit -lt 999 ];then
   echo ok
else
  cat /tmp/audit |mail -s "$date.audit" ymyjohnny@adsame.com scott_gao@adsame.com arthur_wang@adsame.com alex_zheng@adsame.com

fi


if [ $censor -lt 999 ];then
   echo ok
else
  cat /tmp/censor |mail -s "$date.censor" ymyjohnny@adsame.com scott_gao@adsame.com arthur_wang@adsame.com alex_zheng@adsame.com

fi

