---
title: Golong - 有缓冲通道并发实例
toc: true
comments: true
share: true
description: false
date: 2017-12-07 17:18:45
tags:
 - Golang
 - Go
categories:
 - Golang
---

## 需求
我的需求是从数据表获取数据根据业务处理完成，塞到到Es中，由于数据量大，原来是由PHP脚本多进程分批次处理，现在改为Go并发处理。
也算是对go并发的一个实例, 分享下。<!-- more -->


## 问题

今天用golang重写处理数据守护进程时遇到了一个问题，由于我采用了别人的orm，发现存在竞争关系，我没有去看其源码，干脆不用orm,将问题解决。

## 思路

其实最先想到的就是 生产者与消费者模式 ，开启一个goroutine 生产Id，放入channel（有缓冲） ，再由N多goroutine消费Id。

## 代码

```go
package main

import (
	"fmt"
	"sync"
	_ "github.com/go-sql-driver/mysql"
	"database/sql"
	"time"
)

const (
	numberGoroutines = 150  // goroutines 数量
	taskLoad         = 55555  // 数据库自增最大ID,也就任务量
)


var wg sync.WaitGroup

var db = &sql.DB{}

func init(){

	db,_ = sql.Open("mysql", "username:password@tcp(xxx.xxx.xxx.xxx:3306)/db_name?charset=utf8")
}


func main() {

	//记录开始时间
	t1 := time.Now() 

	tasks := make(chan int, taskLoad)

	wg.Add(numberGoroutines)

	for gr := 1; gr <= numberGoroutines; gr++ {

		go worker(tasks, gr)
	}

	for post := 1; post <= taskLoad; post++ {

		tasks <- post
	}

	close(tasks)

	wg.Wait()

    //结束时间
	elapsed := time.Since(t1)
	fmt.Println("App elapsed: ", elapsed)
}


func worker(tasks chan int, worker int) {

    defer wg.Done()
    
	for {

		task, ok := <- tasks
		if !ok {

			return
		}

		sql := "SELECT xxx_id,name FROM tablename where xxx_id=" + fmt.Sprintf("%d",task)

		rows, err := db.Query(sql)

		if err != nil {

			panic(err)
		}

		for rows.Next() {
			var xxx_id int
			var name string

			rows.Columns()
			err = rows.Scan(&xxx_id, &name)

			if err != nil {
				panic(err)
			}

            //code.....  业务处理....
            fmt.Println(name)
            
		}

	}
}
```

