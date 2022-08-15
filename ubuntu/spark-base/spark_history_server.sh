#!/bin/bash

. ${SPARK_HOME}/sbin/spark-config.sh

. ${SPARK_HOME}/bin/load-spark-env.sh

mkdir -p $SPARK_HS_LOG_DIR

LOG=$SPARK_HS_LOG_DIR/spark-history-server.out

ln -sf /dev/stdout $LOG

HDFS_LOG_DIR=/tmp/spark/events

hadoop fs -mkdir -p ${HDFS_LOG_DIR}

export SPARK_HISTORY_OPTS="-Dspark.history.fs.logDirectory=${CORE_CONF_fs_defaultFS}${HDFS_LOG_DIR} -Dspark.history.ui.port=18081"

cd ${SPARK_HOME}/bin

./spark-class org.apache.spark.deploy.history.HistoryServer >> $LOG