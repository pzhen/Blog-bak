---
title: Golang - sync.WaitGroup
toc: true
comments: true
share: true
description: false
date: 2017-12-05 10:46:24
tags:
 - Golang
 - sync.WaitGroup
 - Go
categories:
 - Golang
---

golang中有2种方式同步程序，一种使用channel，另一种使用锁机制。使用channel的案例可以参考博客：[golang--使用channel来同步goroutine](http://www.cnblogs.com/getong/archive/2013/03/19/2970045.html)，这里要涉及的是锁机制，更具体的是sync.WaitGroup，一种较为简单的同步方法集。

sync.WaitGroup只有3个方法，Add()，Done()，Wait()。其中Done()是Add(-1)的别名。简单的来说，使用Add()添加计数，Done()减掉一个计数，计数不为0, 阻塞Wait()的运行。

要注意的有一点。sync文档已经说明了的，The main goroutine calls Add to set the number of goroutines to wait for. Then each of the goroutines runs and calls Done when finished.也就是说，在运行main函数的goroutine里运行Add()函数，在其他的goroutine里面运行Done()函数。这个我是踩过雷了的。

最简单的案例就是sync文档里面的example，这里简单写了一个例子。

```go
package main

import (
    "fmt"
    "sync"
)

func main() {
    var wg sync.WaitGroup
    for i := 0; i < 100; i++ {
        wg.Add(1)
    }

    for i := 0; i < 100; i++ {
        go wg.Done()
    }
    fmt.Println("exit")
    wg.Wait()
}

func add(wg sync.WaitGroup) {
    wg.Add(1)
}


func done(wg sync.WaitGroup) {
    wg.Done()
}
```

在自己的电脑使用godoc搭载的sync文档中，有一个bug，注明添加该包的方法是import "pkg/sync"。一般程序都是import "sync"。我自己测试了一下，import "sync"才是正确的，import "pkg/sync"编译都通不过。各位也可以测试一下。在golang.org已经改正过来了。


## 参考资料
> - [golang--sync.WaitGroup使用示例](http://www.cnblogs.com/getong/archive/2013/03/29/2988816.html)
> - [golang--使用channel来同步goroutine](http://www.cnblogs.com/getong/archive/2013/03/19/2970045.html)

