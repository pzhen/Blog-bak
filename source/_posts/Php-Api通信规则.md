---
title: Php - Api通信规则
toc: true
date: 2017-07-31 15:34:52
share: true
tags: 
 - Php
 - Api
categories:
 - Php
---

Api 通信中，可以采用非对称加密的方式，来提高安全性，也可以采用，下面的通信规则。

如果采用下面方式，可以将时间戳取前7位有效数字来加密这样每隔十几分钟MD5
就一换，还能避开服务器时间不同步问题，也是不错的选择。

<!-- more -->

``` php

/**
 *生成THQS算法的信息查询串（Query string）
 */
private function get_query_string($info) {
    ksort($info);
    return $this->http_build_query($info);
}

/**
 * 根据数组生成HTTP请求URL参数
 * @param unknown_type $array
 */
private function http_build_query($array) {
    $query = '';
    foreach ($array as $key => $value) {
        $key = self::urlencode($key);
        $value = self::urlencode($value);
        $query .= "$key=$value&";
    }

    if (strlen($query)) {
        $query = substr($query, 0, -1);
    }
    return $query;
}

/**
 * *不要被转义了。
 * @param $string
 */
private function urlencode($string) {
    $string = str_replace('*', '-tSl2nWmMsagD-gEr', $string);
    $string = urlencode($string);
    return str_replace('-tSl2nWmMsagD-gEr', '*', $string);
}

/**
 * 	生成THQS算法的hash值
 *  $salt = API Key 秘钥
 */
private function get_hashed_value($qs, $time, $salt) {
    return strtoupper(md5($qs . "&time=$time&salt=$salt"));
}

/*
 *	return string
*/
private function ccXml(){
    header('Content-Type:text/xml');
    $str = '';
    $str .= "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
    $str .= "<result>OK</result>";
    return $str;
}

```
