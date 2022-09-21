FROM ubuntu-spark-base:hadoop-3.0.0-hive-2.3.7-spark-3.0.0

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV SPARK_HS_LOG_DIR=/var/spark/logs

EXPOSE 18081

CMD ["/root/spark_history_server.sh"]