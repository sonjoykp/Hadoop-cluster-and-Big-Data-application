# Configuring Hadoop cluster and running Big Data application
### Submitted by Elie Rizk and Sonjoy Kumar Paul

Environment Setup
Started an experiment with the CloudLab profile called cisece578-win22-ch1-4node under umich-d-cs-edu project:

Here is the screenshot of the CloudLab experiment: 

Here are the list of addresses of the nodes:
```
c240g5-110209.wisc.cloudlab.us
c240g5-110205.wisc.cloudlab.us
c240g5-110219.wisc.cloudlab.us
c240g5-110201.wisc.cloudlab.us
```

Installed java on all the nodes:
```
sudo apt-get update --fix-missing
echo Y | sudo apt-get install openjdk-8-jdk
```
We added the ssh public key of the master node (node 0) to all other nodes ~/.ssh/authorized_keys file

We can use parallel ssh to copy files from master node to other nodes
parallel-ssh -i -h slaves -O StrictHostKeyChecking=no hostname


## Part1: 
ache Hadoop

Download Hadoop:
```
wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.6/hadoop-2.7.6.tar.gz
tar zvxf hadoop-2.7.6.tar.gz
```
Update configuration:
hadoop-2.7.6/etc/hadoop/core-site.xml:
```
<configuration>
<property>
<name>hadoop.tmp.dir</name>
<value>/users/sonjoyp/hadoop_tmp</value>
<description>A base for other temporary directories.</description>
</property>
<property>
<name>fs.default.name</name>
<value>hdfs://c240g5-110209.wisc.cloudlab.us:9000</value>
</property>
</configuration>
```

hadoop-2.7.6/etc/hadoop/hdfs-site.xml:
```
<configuration>
<configuration>
<property>
<name>dfs.namenode.name.dir</name>
<value>/users/sonjoyp/hadoop-2.7.6/data/namenode</value>
</property>
<property>
<name>dfs.datanode.data.dir</name>
<value>/users/sonjoyp/hadoop-2.7.6/data/datanode</value>
</property>
</configuration>
</configuration>
```
hadoop-2.7.6/etc/hadoop/slaves:\
```
c240g5-110209.wisc.cloudlab.us
c240g5-110205.wisc.cloudlab.us
c240g5-110219.wisc.cloudlab.us
c240g5-110201.wisc.cloudlab.us
```



HDFS status check:

http://c240g5-110209.wisc.cloudlab.us:50070/dfshealth.html












hadoop dfsadmin -report:



Apache Spark

Download spark:
```
wget https://archive.apache.org/dist/spark/spark-2.2.0/spark-2.2.0-bin-hadoop2.7.tgz
tar zvxf spark-2.2.0-bin-hadoop2.7.tgz
```

Update Configuration:

In spark-2.2.0-bin-hadoop2.7/conf/slaves:
```
c240g5-110209.wisc.cloudlab.us
c240g5-110205.wisc.cloudlab.us
c240g5-110219.wisc.cloudlab.us
c240g5-110201.wisc.cloudlab.us
```

Started the Spark standalone cluster:
```
spark-2.2.0-bin-hadoop2.7/sbin/start-all.sh
```
Spark Status: <master_node_IP>:8080














###  2: A simple Spark application

Spark Application Run Status: 








Input file and output folder in the hadoop file system:


























Sorted output file in distributed file system:


The first few rows of the sorted output file:


As can be seen, the table is sorted first by country code (cca2) then by timestamp.
