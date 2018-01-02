---
title: Golang - Receiver 值类型与指针类型
toc: true
comments: true
share: true
description: false
date: 2017-12-05 20:38:02
tags:
 - Golang
 - Go
 - Receiver
categories:
 - Golang
---

## 先看指针类型的receiver：

```go
package main
import (
    "fmt"
)
type BasicEvent struct {
    EventId int
}
func (ev *BasicEvent) updateEventID(id int) {
    ev.EventId = id
}
func main() {
    ev1 := &BasicEvent{EventId: 1}
    fmt.Printf("before update id = %d\n", ev1.EventId)
    ev1.updateEventID(2)
    fmt.Printf("After update id = %d\n", ev1.EventId)
    ev2 := BasicEvent{EventId: 1}
    fmt.Printf("before update id = %d\n", ev2.EventId)
    ev2.updateEventID(2)
    fmt.Printf("After update id = %d\n", ev2.EventId)
}
```

输出的结果是：
```
before update id = 1
After update id = 2
before update id = 1
After update id = 2
```
由此可见，不管调用的时候是个值还是指针，只要是方法的receiver是指针类型，都能够修改调用者的内部状态。我估计这个时候是Go自动做了指针转换。

## 值类型的receiver：

```go
package main
import (
    "fmt"
)
type BasicEvent struct {
    EventId int
}
func (ev BasicEvent) updateEventID(id int) {
    ev.EventId = id
}
func main() {
    ev1 := &BasicEvent{EventId: 1}
    fmt.Printf("before update id = %d\n", ev1.EventId)
    ev1.updateEventID(2)
    fmt.Printf("After update id = %d\n", ev1.EventId)
    ev2 := BasicEvent{EventId: 1}
    fmt.Printf("before update id = %d\n", ev2.EventId)
    ev2.updateEventID(2)
    fmt.Printf("After update id = %d\n", ev2.EventId)
}
```

输出的结果是：
```
before update id = 1
After update id = 1
before update id = 1
After update id = 1
```
由此可见，不管调用的时候是个值还是指针，只要是方法的receiver是值类型，都无法改变调用者的内部状态。
总是可见，主要关注的点是方法定义的时候到底receiver是指针还是值类型，如果receiver是指针，内部状态才可以改。
另外，关于关于传入参数是否可改的问题

```go
package main
import (
    "fmt"
)
type BasicEvent struct {
    EventId int
}
func updateEventIDByPointer(ev *BasicEvent, newID int) {
    ev.EventId = newID
}
func updateEventIDByValue(ev BasicEvent, newID int) {
    ev.EventId = newID
}
func main() {
    ev1 := &BasicEvent{EventId: 1}
    fmt.Printf("before update id = %d\n", ev1.EventId)
    updateEventIDByPointer(ev1, 2)
    fmt.Printf("After update id = %d\n", ev1.EventId)
    ev2 := BasicEvent{EventId: 1}
    fmt.Printf("before update id = %d\n", ev2.EventId)
    updateEventIDByValue(ev2, 2)
    fmt.Printf("After update id = %d\n", ev2.EventId)
    ev3 := &BasicEvent{EventId: 1}
    fmt.Printf("before update id = %d\n", ev3.EventId)
    updateEventIDByValue(*ev3, 2)
    fmt.Printf("After update id = %d\n", ev3.EventId)
    ev4 := BasicEvent{EventId: 1}
    fmt.Printf("before update id = %d\n", ev4.EventId)
    updateEventIDByPointer(&ev4, 2)
    fmt.Printf("After update id = %d\n", ev4.EventId)
}
```

结果如下：
```
before update id = 1
After update id = 2
before update id = 1
After update id = 1
before update id = 1
After update id = 1
before update id = 1
After update id = 2
```
前两个比较好理解。第三个值得注意的是，对指针解引用会创建另一个值对象，所以无法改变内部状态。第四个也好说，取地址后得到了原始值对象的引用，所以可以修改内部状态。


