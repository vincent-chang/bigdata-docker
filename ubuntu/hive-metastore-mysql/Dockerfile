FROM ubuntu:18.04

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV TZ=Asia/Shanghai

RUN ln -snf "/usr/share/zoneinfo/$TZ" /etc/localtime && \
    echo "$TZ" > /etc/timezone && \
    apt-get update && \
    apt-get install -y mysql-server expect

ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=hive
ENV MYSQL_USER=hive
ENV MYSQL_PASSWORD=hive

COPY init_mysql_db.sh /root/
COPY mysqld.cnf /etc/mysql/mysql.conf.d/
RUN chmod a+x /root/*.sh

# VOLUME [ "/var/lib/mysql" ]
EXPOSE 3306

ENTRYPOINT ["/root/init_mysql_db.sh"]
CMD ["bash"]