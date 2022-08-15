FROM ubuntu-hadoop-base:hadoop-2.5.2

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

HEALTHCHECK CMD curl -f http://localhost:9870/ || exit 1

ENV HDFS_CONF_dfs_namenode_name_dir=file:///var/hadoop/dfs/name
RUN mkdir -p /var/hadoop/dfs/name
VOLUME /var/hadoop/dfs/name

EXPOSE 9870

CMD ["/root/start_namenode.sh"]