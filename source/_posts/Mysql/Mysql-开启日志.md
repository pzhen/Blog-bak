---
title: Mysql - 开启日志
toc: true
date: 2017-07-31 17:18:58
share: true
tags:
 - Mysql
 - 日志
categories:
 - Mysql
---

来看下慢查询的开启。<!-- more -->

```
[mysqld]

port=3306
log=D:/mysql.log
log_slow_queries=C:/temp/mysql_slow.log
long_query_time=1
```

show binary logs;

//查看binlog日志
show binlog events in 'mysql-bin.000181';



查看日志是否开启
1).可以通过Mysql配置文件my.cnf来确认（Mysql默认开启二进制日志记录）：
Replication Master Server (default)
binary logging is required for replication
log-bin=mysql-bin
刷新日志
flush logs;
查看当前日志位置
show master status;
查看当前所有日志
show master logs;
清空所有的bin-log日志
reset master;

查看日志内容
mysqlbinlog –no-defaults mysql-bin.00001;
删除bin-log
mysql> purge binary logs to 'ablelee.000003';
Query OK, 0 rows affected (0.16 sec)
关闭 bin-log 日志
找到配置文件my.cnf，对于linux，一般默认在/etc目录下，打开此文件，使用井号(#)注释掉如下两个配置项目即可。
log-bin=mysql-bin
binlog_format=mixed
显示所有日志
mysql> show binary logs;



//查看所有日志
show binary logs;
//查看正在使用的binlog
show master status;

purge binary logs to 'mysql-tb-bin.000005';
这个命令就是清理除mysql-tb-bin.000005以外的其他二进制日志；

//查看binlog日志
show binlog events in 'mysql-bin.000181';