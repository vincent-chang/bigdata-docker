PROJECT_HOME=$(cd `dirname $0`; pwd)
# cd ${PROJECT_HOME}/hadoop-base && ./build.sh
cd ${PROJECT_HOME}/hadoop-namenode && ./build.sh
cd ${PROJECT_HOME}/hadoop-datanode && ./build.sh
cd ${PROJECT_HOME}/hadoop-resource-manager && ./build.sh
cd ${PROJECT_HOME}/hadoop-node-manager && ./build.sh
# cd ${PROJECT_HOME}/hive-metastore-mysql && build.sh
cd ${PROJECT_HOME}/hadoop-hive && ./build.sh
cd ${PROJECT_HOME}/spark-base && ./build.sh
cd ${PROJECT_HOME}/hadoop-node-manager-spark-shuffle && ./build.sh
cd ${PROJECT_HOME}/spark-master && ./build.sh
cd ${PROJECT_HOME}/spark-worker && ./build.sh
cd ${PROJECT_HOME}/spark-history-server && ./build.sh
