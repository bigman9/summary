#!bin/sh
CLUSTER_HOME="/home/hadoop/spark-jars/cluster/"
CHOICE_LOG=$CLUSTER_HOME/log/choice-`date +%Y%m%d`.log
THRESHOLD=16000
echo "-------`date '+%Y-%m-%d %H:%M:%S'`-------"  >>${CHOICE_LOG}



# mysql env #
##
IP="10.0.0.35"
PORT="3306"
DB="MILLIONS"
USER="developer"
PASSWD="welcomesxn"
LAST_VER_SQL="select aggreation_time from APP_VERSION_NEWS_AGGREGATION where is_current='1' order by aggreation_time desc limit 1"
CONNECT="mysql -h${IP}  -P${PORT} -u${USER} -p${PASSWD} -D ${DB}"
##
# mysql sql #
##
LAST_VER=`${CONNECT} -e "${LAST_VER_SQL}"`
LAST_VER=`echo ${LAST_VER}| awk -F' ' '{print $2}'`
COUNT_CENTER_SQL="select count(1)  from APP_CLUSTER_CENTER_${LAST_VER};"
echo "Get center count from ${DB}." >>${CHOICE_LOG}
COUNT_CENTER=`${CONNECT} -e "${COUNT_CENTER_SQL}"`
COUNT_CENTER=`echo ${COUNT_CENTER}| awk -F' ' '{print $2}'`
echo ${COUNT_CENTER} >>${CHOICE_LOG}
if [[ ${COUNT_CENTER} -ge ${THRESHOLD} ]]; then
echo "Center count greater than ${THRESHOLD}, Should renew clustering." >>${CHOICE_LOG}
sh $CLUSTER_HOME/scripts/renew.sh
else
echo "Center count less than ${THRESHOLD}, Still do incremental clustering." >>${CHOICE_LOG}
sh $CLUSTER_HOME/scripts/increment.sh
fi
