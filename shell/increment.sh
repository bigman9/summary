#!bin/bash
export JAVA_HOME=/home/hadoop/jdk1.8.0_77
export SPARK_HOME=/home/hadoop/spark-1.6.0-bin-hadoop2.6
export CLUSTER_HOME=/home/hadoop/spark-jars/cluster/scripts
export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH
DAILY_LOG="/home/hadoop/spark-jars/cluster/log/increment-`date +%Y%m%d`.log"

spark-submit --class com.yty.spark.analysis.scala.aggregation.streaming.ZhClusterSupervised --master spark://server911:7077 --num-executors 2 --executor-memory 6G --executor-cores 3 --driver-memory 4G --total-executor-cores 6 --conf spark.default.parallelism=12  /home/hadoop/spark-jars/cluster/streaming/analysis.scala.jar 12 800 >>$DAILY_LOG 2>&1 &

sudo /etc/drop_caches
