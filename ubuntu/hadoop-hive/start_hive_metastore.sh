#!/bin/bash
cd $HIVE_HOME/bin
./schematool --dbType mysql -validate
IS_VALID=$?
if [ $IS_VALID -ne 0 ]; then
  echo "init hive schema..."
  schematool --dbType mysql --initSchema
fi
./hive --service metastore -v