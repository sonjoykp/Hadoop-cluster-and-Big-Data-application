#/bin/bash

export HADOOP_HOME=~/hadoop-2.7.6
export SPARK_HOME=~/spark-2.2.0-bin-hadoop2.7
export PATH=$PATH:$HADOOP_HOME/bin
export PATH=$PATH:$HADOOP_HOME/sbin
export PATH=$PATH:$SPARK_HOME/bin
export PATH=$PATH:$SPARK_HOME/sbin

wget -O inputfile.csv https://www2.cs.uic.edu/~brents/cs494-cdcs/data/export
hadoop fs -mkdir /distributed-dir
hadoop fs -put inputfile.csv /distributed-dir

MASTER_IP=c240g5-110209.wisc.cloudlab.us
SPARK_PORT=7077
HADOOP_PORT=9000

spark-submit --master spark://$MASTER_IP:$SPARK_PORT --deploy-mode client --executor-memory 32g  spark-sort.py hdfs://$MASTER_IP:$HADOOP_PORT/distributed-dir/inputfile.csv hdfs://$MASTER_IP:$HADOOP_PORT/distributed-dir/sorted-output