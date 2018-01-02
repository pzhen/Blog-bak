---
title: Ubuntu - 搭建Shadowsocks 服务
toc: true
comments: true
share: true
date: 2017-11-14 13:16:20
tags:
 - Shadowsocks
 - SS
 - Ubuntu
categories:
 - Linux
 - SS
---

ubuntu 服务器搭建 Shadowsocks 服务<!-- more -->

### 1. shadowsocks 服务器安装

更新软件源

```
sudo apt-get update
```

然后安装 PIP 环境

```
sudo apt-get install python-pip
```

直接安装 shadowsocks

```
sudo pip install shadowsocks
```

### 2. 运行 shadowsocks 服务器

启动命令如下：如果要停止运行，将命令中的start改成stop。

```
sudo ssserver -p 8388 -k password -m aes-256-cfb -d start
```

也可以使用配置文件进行配置，方法创建/etc/shadowsocks.json文件，填入如下内容：
```
{
    "server":"my_server_ip",
    "server_port":8388,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"mypassword",
    "timeout":300,
    "method":"aes-256-cfb"
}
```

各字段的含义：

| name        | info           | 
| ------------- |:-------------:|
|  server   | 服务器 IP (IPv4/IPv6)，注意这也将是服务端监听的 IP 地址 |
| server_port      | 服务器端口      |
| local_port | 本地端端口    |
|password |用来加密的密码|
|timeout |	超时时间（秒）|
|method	|加密方法，可选择 “bf-cfb”, “aes-256-cfb”, “des-cfb”, “rc4″, 等等。默认是一种不安全的加密，推荐用 “aes-256-cfb”|
|TIPS: |加密方式推荐使用rc4-md5，因为 RC4 比 AES 速度快好几倍，如果用在路由器上会带来显著性能提升。旧的 RC4 加密之所以不安全是因为 Shadowsocks 在每个连接上重复使用 key，没有使用 IV。现在已经重新正确实现，可以放心使用。更多可以看 issue。|


创建完毕后，赋予文件权限：

```
sudo chmod 755 /etc/shadowsocks.json
```

为了支持这些加密方式，你要需要安装

```
sudo apt–get install python–m2crypto
```

然后使用配置文件在后台运行：

```
sudo ssserver -c /etc/shadowsocks.json -d start
```

### 3. 配置开机自启动

编辑 /etc/rc.local 文件

```
sudo vi /etc/rc.local
```

在 exit 0 这一行的上边加入如下

```
/usr/local/bin/ssserver –c /etc/shadowsocks.json
```

或者 不用配置文件 直接加入命令启动如下：

```
/usr/local/bin/ssserver -p 8388 -k password -m aes-256-cfb -d start
```

到此重启服务器后，会自动启动。


## 参考资料
> - [ubuntu 服务器搭建 Shadowsocks 服务](http://blog.csdn.net/hanshileiai/article/details/49302865)
> - [科学上网之 Shadowsocks 安装及优化加速](http://wuchong.me/blog/2015/02/02/shadowsocks-install-and-optimize/)

