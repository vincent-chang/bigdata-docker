# Ubuntu Linux Aarch64 平台下的大数据 Dockers

此项目是以 https://github.com/big-data-europe 作为基础所做的 Ubuntu Linux Aarch64 平台定制开发。

## 项目背景

> * 因为开发环境由 Windows 迁移到 M1 的 MacOS 后，原来使用的 VirtualBox 虚拟机不能用了，
> * 工作上又需要一套 Spark 环境来做本地开发的基本测试。
> * 本来想在 alpine linux 上弄的，不过又因为有些 native 编译不过，所以转到 ubuntu 上了。

## 项目目标
建立一套可以运行在 Apple Silicon M1 机器上的大数据 Docker 镜像。
![image](https://github.com/vincent-chang/bigdata-docker/blob/main/.image/hadoop_checknative.jpg?raw=true)

## 对原组件的改动

* 在 ubuntu aarch64 环境下重新编译了下列组件
> leveldbjni-all
> * libleveldbjni.so: ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, BuildID[sha1]=491f1538f25b84a626ea6ff71413f51c852a1b69, with debug_info, not stripped

> jansi-native
> * libjansi.so: ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, BuildID[sha1]=c72d37fb9945a7a00cbbb0d308db2c1e16d1abf7, with debug_info, not stripped

> lz4-java
> * liblz4-java.so: ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, BuildID[sha1]=621fc55ae8d719fbb79c717d13362e54dadbac2d, not stripped

> netty-transport-native
> * libnetty-transport-native-epoll.so: ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, BuildID[sha1]=a972bba78646a80c92921b1f75608423acc27f8c, not stripped

* 通过升级得到 aarch64 平台支持
> snappy-java
> * libsnappyjava.so: ELF 64-bit LSB shared object, ARM aarch64, version 1 (GNU/Linux), dynamically linked, stripped

## 模块说明

### 单个 Docker（单机）
* hadoop-all: 集成下面所有组件的 docker，一个 container 可启动全套服务（默认没有启动 spark-master 和 spark-worker 服务）。
  
### Docker Compose（集群）
* hadoop-base: 基础的 hadoop 环境。
* name-node: name node 节点
* data-node: data node 节点
* resource-manager: resource manager 节点
* node-manager: node manager 节点
* node-manager-spark-shuffle: 在 yarn 中配置了 spark-shuffle 的 node-manager 节点
* hadoop-history-server: hadoop history server 节点
* hive-metastore-mysql: hive metastore mysql 数据库节点
* hadoop-hive: hive metastore 服务 和 hive server 服务节点
* spark-base: spark 的基础运行环境节点。
* spark-master: spark master 节点
* spark-worker: spark worker 节点
* spark-history-server: spark history server 节点

当前可用的分支：hadoop-2.5.2-hive-1.2.1-spark-1.6.1
