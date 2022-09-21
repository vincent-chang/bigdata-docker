FROM ubuntu-spark-base:hadoop-3.0.0-hive-2.3.7-spark-3.0.0

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV SPARK_WORKER_WEBUI_PORT=8081
ENV SPARK_WORKER_LOG=/var/spark/logs
ENV SPARK_MASTER="spark://spark-master:7077"

VOLUME ["/var/spark"]

EXPOSE 8081

CMD ["/root/spark_worker.sh"]