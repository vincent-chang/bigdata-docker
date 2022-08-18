FROM ubuntu-hadoop-hive:1.2.1-mysql

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV SCALA_VERSION=2.10.4
ENV SPARK_VERSION=1.6.1
ENV SPARK_HIVE_VERSION=1.2.1.spark

ENV HIVE_METASTORE_JDBC_DRIVER=${HIVE_HOME}/lib/mysql-connector-java-5.1.49.jar
ENV SPARK_CLASSPATH=${HIVE_METASTORE_JDBC_DRIVER}

ENV SCALA_URL=https://scala-lang.org/files/archive/scala-${SCALA_VERSION}.tgz
ENV SCALA_HOME=/opt/scala-${SCALA_VERSION}

ENV SPARK_URL=https://github.com/vincent-chang/spark/releases/download/v${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz
ENV SPARK_HOME=/opt/spark-${SPARK_VERSION}
ENV PATH=${SPARK_HOME}/bin:${SCALA_HOME}/bin:$PATH

COPY wait-for-step.sh /root/
COPY execute-step.sh /root/
COPY finish-step.sh /root/
COPY spark_master.sh /root/
COPY spark_worker.sh /root
COPY spark_history_server.sh /root/

RUN set -x && \
    curl -fSL "${SCALA_URL}" -o /tmp/scala.tgz && \
    tar -xvf /tmp/scala.tgz -C /opt/ && \
    chown -R root:root /opt/scala-${SCALA_VERSION} && \
    rm /tmp/scala.tgz && \
    curl -fSL "${SPARK_URL}" -o /tmp/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz && \
    tar -xvf /tmp/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz -C /opt/ && \
    rm /tmp/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz && \
    mv /opt/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION} /opt/spark-${SPARK_VERSION} && \
    chown -R root:root /opt/spark-${SPARK_VERSION} && \
    cd /opt/spark-${SPARK_VERSION}/conf && \
    ln -s ${HIVE_HOME}/conf/hive-site.xml hive-site.xml && \
    cp ${SPARK_HOME}/lib/spark-${SPARK_VERSION}-yarn-shuffle.jar ${HADOOP_YARN_LIB_DIR}/ && \
    rm -f /opt/spark-${SPARK_VERSION}/lib/datanucleus-*.jar && \
    cp ${HIVE_HOME}/lib/datanucleus-*.jar /opt/spark-${SPARK_VERSION}/lib/ && \
    chmod a+x /root/*.sh

ENV ENABLE_INIT_DAEMON true
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init
ENV PYTHONHASHSEED 1

VOLUME ["/var/spark"]

CMD ["bash"]