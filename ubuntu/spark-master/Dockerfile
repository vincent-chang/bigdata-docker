FROM ubuntu-spark-base:hadoop-2.5.2-hive-1.2.1-spark-1.6.1

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV SPARK_MASTER_PORT=7077
ENV SPARK_MASTER_WEBUI_PORT=8080
ENV SPARK_MASTER_LOG=/var/spark/logs

EXPOSE 8080 7077 6066

CMD ["/root/spark_master.sh"]