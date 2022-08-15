FROM ubuntu-spark-base:hadoop-2.5.2-hive-1.2.1-spark-1.6.1

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV SPARK_WORKER_WEBUI_PORT=8081
ENV SPARK_WORKER_LOG=/var/spark/logs
ENV SPARK_MASTER="spark://spark-master:7077"

EXPOSE 8081

CMD ["/root/spark_worker.sh"]