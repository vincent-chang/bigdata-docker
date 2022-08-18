FROM ubuntu:18.04

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV TZ=Asia/Shanghai

RUN ln -snf "/usr/share/zoneinfo/$TZ" /etc/localtime && \
    echo "$TZ" > /etc/timezone && \
    echo 'Acquire::Retries "10";' > /etc/apt/apt.conf.d/80-retries && \
    apt-get update && \
    apt-get install -y net-tools netcat curl perl mysql-server expect \
        libsysfs2 libssl1.0.0=1.0.2n-1ubuntu5.10 libtirpc1 zlib1g libbz2-1.0 liblz4-1 libsnappy1v5 libapr1 \
        openjdk-8-jdk && \
    apt-get clean && \
    mkdir -p /var/mysql && \
    mkdir -p /var/run/mysql && \
    mkdir -p /var/lib/mysql && \
    mkdir -p /var/log/mysql && \
    mv /var/run/mysql /var/mysql/run && \
    mv /var/lib/mysql /var/mysql/lib && \
    mv /var/log/mysql /var/mysql/log && \
    ln -s /var/mysql/run /var/run/mysql && \
    ln -s /var/mysql/lib /var/lib/mysql && \
    ln -s /var/mysql/log /var/log/mysql && \
    chown -R mysql:mysql /var/mysql

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-arm64

ENV HADOOP_VERSION=2.5.2
ENV HADOOP_URL=https://github.com/vincent-chang/hadoop/releases/download/release-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz
ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV PATH=${HADOOP_HOME}/bin:$PATH

RUN curl -fSL "${HADOOP_URL}" -o /tmp/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar -xvf /tmp/hadoop-${HADOOP_VERSION}.tar.gz -C /opt/ && \
    rm /tmp/hadoop-${HADOOP_VERSION}.tar.gz && \
    chown -R root:root /opt/hadoop-${HADOOP_VERSION} && \
    ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop && \
    mkdir -p /var/hadoop/dfs/name && \
    mkdir -p /var/hadoop/dfs/data && \
    mkdir -p /var/hadoop/yarn/timeline && \
    ln -s /var/hadoop/logs /opt/hadoop-$HADOOP_VERSION/logs

ENV HIVE_VERSION=1.2.1
ENV HIVE_URL=https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz

ENV HIVE_HOME=/opt/hive
ENV PATH=$HIVE_HOME/bin:$PATH

ENV HADOOP_YARN_LIB_DIR=${HADOOP_HOME}/share/hadoop/yarn/lib

RUN curl -fSL "${HIVE_URL}" -o /tmp/apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    tar -xvf /tmp/apache-hive-${HIVE_VERSION}-bin.tar.gz -C /opt/ && \
    rm /tmp/apache-hive-${HIVE_VERSION}-bin.tar.gz && \
	mv /opt/apache-hive-${HIVE_VERSION}-bin /opt/hive && \
	rm /opt/hadoop-${HADOOP_VERSION}/share/hadoop/yarn/lib/jline-*.jar && \
	cp /opt/hive/lib/jline-*.jar /opt/hadoop-${HADOOP_VERSION}/share/hadoop/yarn/lib/ && \
	rm -f ${HADOOP_YARN_LIB_DIR}/datanucleus-*.jar && \
    cp ${HIVE_HOME}/lib/datanucleus-*.jar ${HADOOP_YARN_LIB_DIR}/

COPY mysql-connector-java-5.1.49.jar ${HIVE_HOME}/lib/
COPY mysql-connector-java-5.1.49.jar ${HADOOP_YARN_LIB_DIR}/
COPY conf/hive-site.xml ${HIVE_HOME}/conf
COPY conf/beeline-log4j2.properties ${HIVE_HOME}/conf
COPY conf/hive-env.sh ${HIVE_HOME}/conf
COPY conf/hive-exec-log4j2.properties ${HIVE_HOME}/conf
COPY conf/hive-log4j2.properties ${HIVE_HOME}/conf
COPY conf/ivysettings.xml ${HIVE_HOME}/conf
COPY conf/llap-daemon-log4j2.properties ${HIVE_HOME}/conf

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

RUN curl -fSL "${SCALA_URL}" -o /tmp/scala.tgz && \
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
    mkdir -p /var/spark/logs

ENV CLUSTER_NAME=bigdata
ENV MULTIHOMED_NETWORK=1

ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=hive
ENV MYSQL_USER=hive
ENV MYSQL_PASSWORD=hive

ENV CORE_CONF_fs_defaultFS=hdfs://localhost:9000
ENV CORE_CONF_hadoop_http_staticuser_user=root
ENV CORE_CONF_hadoop_proxyuser_hue_hosts=*
ENV CORE_CONF_hadoop_proxyuser_hue_groups=*
ENV CORE_CONF_io_compression_codecs=org.apache.hadoop.io.compress.SnappyCodec

ENV HDFS_CONF_dfs_namenode_name_dir=file:///var/hadoop/dfs/name
ENV HDFS_CONF_dfs_datanode_data_dir=file:///var/hadoop/dfs/data
ENV HDFS_CONF_dfs_webhdfs_enabled=true
ENV HDFS_CONF_dfs_permissions_enabled=false
ENV HDFS_CONF_dfs_replication=1
ENV HDFS_CONF_dfs_namenode_datanode_registration_ip___hostname___check=false

ENV YARN_CONF_yarn_log___aggregation___enable=true
ENV YARN_CONF_yarn_log_server_url=http://localhost:8188/applicationhistory/logs/
ENV YARN_CONF_yarn_resourcemanager_recovery_enabled=true
ENV YARN_CONF_yarn_resourcemanager_store_class=org.apache.hadoop.yarn.server.resourcemanager.recovery.FileSystemRMStateStore
ENV YARN_CONF_yarn_resourcemanager_scheduler_class=org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler
ENV YARN_CONF_yarn_scheduler_capacity_root_default_maximum___allocation___mb=8192
ENV YARN_CONF_yarn_scheduler_capacity_root_default_maximum___allocation___vcores=4
ENV YARN_CONF_yarn_resourcemanager_fs_state___store_uri=/rmstate
ENV YARN_CONF_yarn_resourcemanager_system___metrics___publisher_enabled=true
ENV YARN_CONF_yarn_resourcemanager_hostname=localhost
ENV YARN_CONF_yarn_resourcemanager_address=localhost:8032
ENV YARN_CONF_yarn_resourcemanager_scheduler_address=localhost:8030
ENV YARN_CONF_yarn_resourcemanager_resource__tracker_address=localhost:8031
ENV YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path=/var/hadoop/yarn/timeline
ENV YARN_CONF_yarn_timeline___service_enabled=true
ENV YARN_CONF_yarn_timeline___service_generic___application___history_enabled=true
ENV YARN_CONF_yarn_timeline___service_hostname=localhost
ENV YARN_CONF_mapreduce_map_output_compress=true
ENV YARN_CONF_mapred_map_output_compress_codec=org.apache.hadoop.io.compress.SnappyCodec
ENV YARN_CONF_yarn_nodemanager_resource_memory___mb=16384
ENV YARN_CONF_yarn_nodemanager_resource_cpu___vcores=8
ENV YARN_CONF_yarn_nodemanager_disk___health___checker_max___disk___utilization___per___disk___percentage=98.5
ENV YARN_CONF_yarn_nodemanager_remote___app___log___dir=/app-logs
ENV YARN_CONF_yarn_nodemanager_aux___services=mapreduce_shuffle,spark_shuffle
ENV YARN_CONF_yarn_nodemanager_aux___services_spark__shuffle_class=org.apache.spark.network.yarn.YarnShuffleService

ENV MAPRED_CONF_mapreduce_framework_name=yarn
ENV MAPRED_CONF_mapred_child_java_opts=-Xmx4096m
ENV MAPRED_CONF_mapreduce_map_memory_mb=4096
ENV MAPRED_CONF_mapreduce_reduce_memory_mb=8192
ENV MAPRED_CONF_mapreduce_map_java_opts=-Xmx3072m
ENV MAPRED_CONF_mapreduce_reduce_java_opts=-Xmx6144m
ENV MAPRED_CONF_yarn_app_mapreduce_am_env="HADOOP_MAPRED_HOME=/opt/hadoop-2.5.2/"
ENV MAPRED_CONF_mapreduce_map_env="HADOOP_MAPRED_HOME=/opt/hadoop-2.5.2/"
ENV MAPRED_CONF_mapreduce_reduce_env="HADOOP_MAPRED_HOME=/opt/hadoop-2.5.2/"

ENV HIVE_SITE_CONF_javax_jdo_option_ConnectionURL="jdbc:mysql://localhost/hive?useSSL=false"
ENV HIVE_SITE_CONF_javax_jdo_option_ConnectionDriverName=com.mysql.jdbc.Driver
ENV HIVE_SITE_CONF_javax_jdo_option_ConnectionUserName=hive
ENV HIVE_SITE_CONF_javax_jdo_option_ConnectionPassword=hive
ENV HIVE_SITE_CONF_datanucleus_autoCreateSchema=true
ENV HIVE_SITE_CONF_hive_metastore_uris=thrift://localhost:9083

ENV SPARK_MASTER_PORT=7077
ENV SPARK_MASTER_WEBUI_PORT=8080
ENV SPARK_MASTER_LOG=/var/spark/logs

ENV SPARK_WORKER_WEBUI_PORT=8081
ENV SPARK_WORKER_LOG=/var/spark/logs
ENV SPARK_MASTER="spark://localhost:7077"

COPY entry_point.sh /root/
COPY mysqld.cnf /etc/mysql/mysql.conf.d/
COPY start_namenode.sh /root/
COPY start_datanode.sh /root/
COPY start_resource_manager.sh /root/
COPY start_node_manager.sh /root/
COPY start_history_server.sh /root/
COPY start_hive_metastore.sh /root/
COPY start_hive_server.sh /root/
COPY spark_master.sh /root/
COPY spark_worker.sh /root
COPY spark_history_server.sh /root/

RUN chmod a+x /root/*.sh
WORKDIR /opt/

VOLUME ["/var/mysql", "/var/hadoop", "/var/spark"]
ENTRYPOINT ["bash", "/root/entry_point.sh"]
CMD ["/bin/bash"]