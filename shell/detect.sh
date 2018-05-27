#!bin/bash
SS="org.apache.spark.deploy.SparkSubmit"
SI="org.apache.spark.deploy.SparkSubmit --master"
CUR_JPS=`ps aux | grep "$SS"`
if [[ $CUR_JPS == *$SS* && $CUR_JPS == *$SI* ]] 
then
echo "The clustering process not yet completed"
else 
sh /home/hadoop/spark-jars/cluster/scripts/max.sh
fi
