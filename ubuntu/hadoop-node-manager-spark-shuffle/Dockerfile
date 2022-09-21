FROM ubuntu-spark-base:hadoop-3.0.0-hive-2.3.7-spark-3.0.0

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

HEALTHCHECK CMD curl -f http://localhost:8042/ || exit 1

EXPOSE 8042

CMD ["/root/start_node_manager.sh"]