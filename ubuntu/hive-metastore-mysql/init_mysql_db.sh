#!/bin/sh

service mysql status|grep "stopped"
ret_code=$?
if [ "$ret_code" -eq 0 ]; then
  echo "[i] Starting mysql service..."
  service mysql start
fi

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
  echo "[i] Hive data directory already present, skipping creation."
else
  echo "[i] Hive data directory not found, creating initial DBs."

  if [ "$MYSQL_ROOT_PASSWORD" = "" ]; then
    MYSQL_ROOT_PASSWORD=root
    echo "[i] MySQL root Password: $MYSQL_ROOT_PASSWORD"
  fi

  SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"VALIDATE PASSWORD plugin?\"
send \"n\r\"
expect \"New password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"
expect \"Re-enter new password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"n\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

  echo "$SECURE_MYSQL"

  MYSQL_DATABASE=${MYSQL_DATABASE:-""}

  sql_file=`mktemp`
  if [ ! -f "$sql_file" ]; then
      return 1
  fi

  echo "FLUSH PRIVILEGES;" >$sql_file

  if [ "$MYSQL_DATABASE" != "" ]; then
    echo "[i] Creating database: $MYSQL_DATABASE"
    echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" >> $sql_file

    if [ "$MYSQL_USER" != "" ] && [ "$MYSQL_PASSWORD" != "" ]; then
      echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $sql_file
      echo "CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $sql_file
      echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION;" >> $sql_file
      echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'localhost' WITH GRANT OPTION;" >> $sql_file
      echo "FLUSH PRIVILEGES;" >> $sql_file
    fi
  fi

  mysql -uroot -p$MYSQL_ROOT_PASSWORD < $sql_file
  rm -f $sql_file

fi

exec $@