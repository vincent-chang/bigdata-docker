#!/bin/bash

function wait_for_hdfs()
{
  local retry_seconds=5
  local max_try=100
  let i=1

  hdfs dfsadmin -safemode get|grep "OFF"
  result=$?

  until [ $result -eq 0 ]; do
    echo "[$i/$max_try] check for hdfs safe mode..."
    echo "[$i/$max_try] hdfs safe mode is ON."

    if (( $i == $max_try )); then
      echo "[$i/$max_try] hdfs safe mode is still ON; giving up after ${max_try} tries. :/"
      exit 1
    fi

    echo "[$i/$max_try] try in ${retry_seconds}s once again ..."
    let "i++"
    sleep $retry_seconds

    hdfs dfsadmin -safemode get|grep "OFF"
    result=$?
  done
  echo "[$i/$max_try] hdfs safe mode is OFF."
}

wait_for_hdfs
$HADOOP_HOME/bin/yarn --config $HADOOP_CONF_DIR resourcemanager