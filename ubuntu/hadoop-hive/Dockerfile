FROM ubuntu-hadoop-base:hadoop-3.0.0

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV HIVE_VERSION=2.3.7
ENV HIVE_URL=https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz

ENV HIVE_HOME=/opt/hive
ENV PATH=$HIVE_HOME/bin:$PATH

ENV HADOOP_YARN_LIB_DIR=${HADOOP_HOME}/share/hadoop/yarn/lib

COPY start_hive_metastore.sh /root/
COPY start_hive_server.sh /root/
COPY entry_point.sh /root/

WORKDIR /opt

RUN curl -fSL "${HIVE_URL}" -o /tmp/apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    tar -xvf /tmp/apache-hive-${HIVE_VERSION}-bin.tar.gz -C /opt/ && \
    rm /tmp/apache-hive-${HIVE_VERSION}-bin.tar.gz && \
	mv /opt/apache-hive-${HIVE_VERSION}-bin /opt/hive && \
	chmod +x /root/*.sh

COPY mysql-connector-java-5.1.49.jar ${HIVE_HOME}/lib/
COPY mysql-connector-java-5.1.49.jar ${HADOOP_YARN_LIB_DIR}/
COPY conf/hive-site.xml ${HIVE_HOME}/conf
COPY conf/beeline-log4j2.properties ${HIVE_HOME}/conf
COPY conf/hive-env.sh ${HIVE_HOME}/conf
COPY conf/hive-exec-log4j2.properties ${HIVE_HOME}/conf
COPY conf/hive-log4j2.properties ${HIVE_HOME}/conf
COPY conf/ivysettings.xml ${HIVE_HOME}/conf
COPY conf/llap-daemon-log4j2.properties ${HIVE_HOME}/conf

EXPOSE 10000
EXPOSE 10002

CMD ["/root/start_hive_server.sh"]