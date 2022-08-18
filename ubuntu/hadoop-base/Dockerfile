FROM ubuntu:18.04

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV TZ=Asia/Shanghai

RUN ln -snf "/usr/share/zoneinfo/$TZ" /etc/localtime && \
    echo "$TZ" > /etc/timezone && \
    echo 'Acquire::Retries "10";' > /etc/apt/apt.conf.d/80-retries && \
    apt-get update && \
    apt-get install -y net-tools netcat curl perl \
        libsysfs2 libssl1.0.0=1.0.2n-1ubuntu5.10 libtirpc1 zlib1g libbz2-1.0 liblz4-1 libsnappy1v5 libapr1 \
        openjdk-8-jdk && \
    apt-get clean

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-arm64

ENV HADOOP_VERSION=2.5.2
ENV HADOOP_URL=https://github.com/vincent-chang/hadoop/releases/download/release-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz
ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV PATH=${HADOOP_HOME}/bin:$PATH

COPY entry_point.sh /root/
COPY start_namenode.sh /root/
COPY start_datanode.sh /root/
COPY start_resource_manager.sh /root/
COPY start_node_manager.sh /root/
COPY start_history_server.sh /root/

RUN curl -fSL "${HADOOP_URL}" -o /tmp/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar -xvf /tmp/hadoop-${HADOOP_VERSION}.tar.gz -C /opt/ && \
    rm /tmp/hadoop-${HADOOP_VERSION}.tar.gz && \
    chown -R root:root /opt/hadoop-${HADOOP_VERSION} && \
    ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop && \
	mkdir -p /var/hadoop/dfs/name && \
    mkdir -p /var/hadoop/dfs/data && \
    mkdir -p /var/hadoop/yarn/timeline && \
    ln -s /var/hadoop/logs /opt/hadoop-$HADOOP_VERSION/logs && \
    chmod a+x /root/*.sh

ENV MULTIHOMED_NETWORK=1

VOLUME ["/var/hadoop"]
ENTRYPOINT ["bash", "/root/entry_point.sh"]
CMD ["/bin/bash"]