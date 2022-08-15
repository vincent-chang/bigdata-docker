FROM ubuntu-spark-base:hadoop-2.5.2-hive-1.2.1-spark-1.6.1

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

HEALTHCHECK CMD curl -f http://localhost:8042/ || exit 1

EXPOSE 8042

CMD ["/root/start_node_manager.sh"]