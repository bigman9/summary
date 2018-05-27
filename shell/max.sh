#!bin/bash

# mysql env #
##
IP="10.0.0.35"
PORT="3306"
DB_M="MILLIONS"
USER="developer"
PASSWD="welcomesxn"
LAST_VER_SQL="select aggreation_time from APP_VERSION_NEWS_AGGREGATION where is_current='1' order by aggreation_time desc limit 1"
CONNECT="mysql -h${IP}  -P${PORT} -u${USER} -p${PASSWD} -D ${DB_M}"
##
# mysql sql #
##
DB_S="MILLIONS_CRAWLER"
MAX_VER_SQL="select max(last_news_id) from APP_VERSION_NEWS_AGGREGATION"
MAX_VER=`${CONNECT} -e "${MAX_VER_SQL}"`
MAX_VER=`echo ${MAX_VER}| awk -F' ' '{print $2}'`
CONNECT_S="mysql -h${IP}  -P${PORT} -u${USER} -p${PASSWD} -D ${DB_S}"
MAX_NEWS_SQL="select max(id) from APP_SOURCE_DATA_NEWS_CN"
MAX_NEWS=`${CONNECT_S} -e "${MAX_NEWS_SQL}"`
MAX_NEWS=`echo ${MAX_NEWS}| awk -F' ' '{print $2}'`
MAX_VER=`expr ${MAX_VER} + 800`
if [[ ${MAX_NEWS} -ge ${MAX_VER} ]]; then
sh /home/hadoop/spark-jars/cluster/scripts/choice.sh
echo "${MAX_NEWS} > ${MAX_VER} over 800"
else
echo "The corpus is not rich enough"
fi
