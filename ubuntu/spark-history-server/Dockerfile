FROM ubuntu-spark-base:hadoop-2.5.2-hive-1.2.1-spark-1.6.1

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV SPARK_HS_LOG_DIR=/var/spark/logs

EXPOSE 18081

CMD ["/root/spark_history_server.sh"]