---
title: Mysql - 开启慢查询
toc: true
comments: true
share: true
date: 2017-09-19 15:13:10
tags:
 - Mysql
 - 慢查询
categories:
 - Mysql
---

Mysql 启动慢查询日志 （不用重启）<!-- more -->

## 1. 查看mysql系统参数


```
mysql> show variables like "%slow%";
+---------------------------+-------------------------------+
| Variable_name             | Value                         |
+---------------------------+-------------------------------+
| log_slow_admin_statements | OFF                           |
| log_slow_slave_statements | OFF                           |
| slow_launch_time          | 2                             |
| slow_query_log            | OFF                           |
| slow_query_log_file       | /mysql/data/nagiosdb-slow.log |
+---------------------------+-------------------------------+
5 rows in set (0.00 sec)


slow_query_log： off关闭状态  on开启状态
slow_launch_time   默认超过2s为慢查询
slow_query_log_file  慢查询日志存放地点
```

这三个参数，在不同的mysql版本中，不太一样，不过都可以通过 show variables like "%slow%" 查看出来


## 2. 运行如下命令即可运行慢查询日志
```
mysql> set global slow_query_log=ON;
Query OK, 0 rows affected (0.03 sec)

mysql> set global slow_launch_time=5;
Query OK, 0 rows affected (0.00 sec)

mysql> show variables like "%slow%";
+---------------------------+-------------------------------+
| Variable_name             | Value                         |
+---------------------------+-------------------------------+
| log_slow_admin_statements | OFF                           |
| log_slow_slave_statements | OFF                           |
| slow_launch_time          | 5                             |
| slow_query_log            | ON                            |
| slow_query_log_file       | /mysql/data/nagiosdb-slow.log |
+---------------------------+-------------------------------+
5 rows in set (0.00 sec)
```

mysql 5.1.6版本起，slow_query_log 和 slow_launch_time 支持写文件或写数据库表两种方式，并且日志的开启，输出方式的修改，都可以在global级别动态修改。
只需简单通过set global slow_query_log=ON;即可开启慢查询，而不需要重启数据库！


## 3. 可以直接写到配置文件中  my.cnf

```
slow_query_log_file=/mysql/log/nagiosdb-slow.log
slow_launch_time=5
```
可以完成配置！！


