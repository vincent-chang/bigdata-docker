FROM ubuntu:18.04

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV TZ=Asia/Shanghai

RUN ln -snf "/usr/share/zoneinfo/$TZ" /etc/localtime && \
    echo "$TZ" > /etc/timezone && \
    apt-get update && \
    apt-get install -y mysql-server expect && \
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

ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=hive
ENV MYSQL_USER=hive
ENV MYSQL_PASSWORD=hive

COPY init_mysql_db.sh /root/
COPY mysqld.cnf /etc/mysql/mysql.conf.d/
RUN apt-get clean && \
    chmod a+x /root/*.sh

VOLUME [ "/var/mysql" ]
EXPOSE 3306

ENTRYPOINT ["/root/init_mysql_db.sh"]
CMD ["bash"]