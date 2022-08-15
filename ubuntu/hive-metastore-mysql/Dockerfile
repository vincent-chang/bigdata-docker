FROM mysql:8.0.30

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV TZ=Asia/Shanghai

RUN ln -snf "/usr/share/zoneinfo/$TZ" /etc/localtime && \
    echo "$TZ" > /etc/timezone

ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=hive
ENV MYSQL_USER=hive
ENV MYSQL_PASSWORD=hive

COPY hive.cnf /etc/mysql/conf.d
COPY hive-schema.mysql.sql /docker-entrypoint-initdb.d/
COPY hive-txn-schema.mysql.sql /docker-entrypoint-initdb.d/

EXPOSE 3306
CMD ["mysqld"]