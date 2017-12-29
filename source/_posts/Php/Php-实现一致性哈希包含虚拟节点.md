---
title: Php - 一致性哈希
toc: true
date: 2017-07-20 10:43:35
share: true
tags:
 - Php
 - 一致性Hash
categories:
 - Php
---

之前看到Es的分片路由机制，想到了分布式的一致性哈希，

从无虚拟哈希环，到添加上虚拟哈希环。

下面是php的实现。

``` php
<?php

function myHash($str) {
    $hash = 0;
    $s    = md5($str);
    $seed = 5;
    $len  = 32;
    for ($i = 0; $i < $len; $i++) {
        $hash = ($hash << $seed) + $hash + ord($s{$i});
    }
    return $hash & 0x7FFFFFFF;
}

class ConsistentHash {

    #每个物理节点生成虚拟节点个数
    public $virtual_num = 300;

    // server列表
    public $_server_list = array();
    // 延迟排序，因为可能会执行多次addServer
    private $_layze_sorted = FALSE;

    #server物理节点
    public function addServer($server) {
        $hash = myHash($server);
        $this->_layze_sorted = FALSE;

        if (!isset($this->_server_list[$hash])) {
            $this->_server_list[$hash] = $server;
        }

        return $this;
    }


    #server虚拟节点
    public function addServerVir($server) {

        for ($i = 1; $i <= $this->virtual_num; $i++)
        {
            $hash_key = myHash($server."#".$i);
            if(!isset($this->_server_list[$hash_key]))
            {
                $this->_server_list[$hash_key] = $server;
            }
        }

        return $this;

    }


    public function find($key) {
        // 排序
        if (!$this->_layze_sorted) {
            ksort($this->_server_list);
            $this->_layze_sorted = TRUE;
        }

        #print_r($this->_server_list);exit();

        $hash = myHash($key);
        $len  = sizeof($this->_server_list);
        if ($len == 0) {
            return FALSE;
        }

        $keys   = array_keys($this->_server_list);  #server hash 值
        $values = array_values($this->_server_list);  #server 地址

        if ($hash <= $keys[0] || $hash >= $keys[$len - 1]) {
            return $values[0];
        }

        foreach ($keys as $key=>$pos) {
            $next_pos = NULL;
            if (isset($keys[$key + 1]))
            {
                $next_pos = $keys[$key + 1];
            }

            if (is_null($next_pos)) {
                return $values[$key];
            }

            // 区间判断
            if ($hash >= $pos && $hash <= $next_pos) {
                return $values[$key];
            }
        }
    }
}
$consisHash = new ConsistentHash();

#物理节点hash环
#$consisHash->addServer("server1")->addServer("server2")->addServer("server3")->addServer("server4");

#带虚拟节点的hash环
$consisHash->addServerVir("server1")->addServerVir("server2")->addServerVir("server3")->addServerVir("server4");

$total_server1_num = $total_server2_num = $total_server3_num = $total_server4_num = 0;
for ($i=1; $i <= 200000; $i++) {
    # code...
    $key = uniqid(TRUE,TRUE);

    $server_name = $consisHash->find($key);
    if($server_name == "server1"){
        $total_server1_num += 1;
    }

    if($server_name == "server2"){
        $total_server2_num += 1;
    }

    if($server_name == "server3"){
        $total_server3_num += 1;
    }

    if($server_name == "server4"){
        $total_server4_num += 1;
    }

}

echo "server1 num :" .$total_server1_num ."\n";
echo "server2 num :" .$total_server2_num ."\n";
echo "server3 num :" .$total_server3_num ."\n";
echo "server4 num :" .$total_server4_num ."\n";
?>

```

## 参考资料
- [flexihash](https://github.com/pda/flexihash)
