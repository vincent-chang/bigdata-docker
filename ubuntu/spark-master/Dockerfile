FROM ubuntu-spark-base:hadoop-3.0.0-hive-2.3.7-spark-3.0.0

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV SPARK_MASTER_PORT=7077
ENV SPARK_MASTER_WEBUI_PORT=8080
ENV SPARK_MASTER_LOG=/var/spark/logs

VOLUME ["/var/spark"]

EXPOSE 8080 7077 6066

CMD ["/root/spark_master.sh"]