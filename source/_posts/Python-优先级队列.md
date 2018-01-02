---
title: Python - 优先级队列
toc: true
date: 2017-07-21 15:22:32
share: true
tags:
 - Python
 - 队列
 - 优先级队列
categories:
 - Python
---

优先级队列是一种容器型数据结构，它能管理一队记录，并按照排序字段（例如一个数字类型的权重值）为其排序。由于是排序的，所以在优先级队列中你可以快速获取到最大的和最小的值。
<!-- more -->
你可以认为优先级队列是一种修改过的普通队列：普通队列依据记录插入的时间来获取下一个记录，优先级队列依据优先级来获取下一个记录，而优先级取决于排序字段的值。

优先级队列经常用来解决调度问题，比如给更紧急的任务更高的优先级。

我们以操作系统的任务调度为例：高优先级的任务（比如实时游戏）应该先于低优先级的任务（比如后台下载软件更新）执行。通过在优先级队列中依据任务的紧急程度排序，我们能让最紧急的任务优先得到执行。


queue.PriorityQueue类


``` python
import Queue

q = Queue.PriorityQueue()

q.put((2,'code'))
q.put((1,'eat'))
q.put((3,'sleep'))

while not q.empty():
	next_item = q.get()
	print(next_item)

# Result
# (1,'eat')
# (2, 'code')
# (3, 'sleep')
```


这个优先级队列内部使用了heapq，所以它的时间复杂度和heapq是相同的。

不同的是PriorityQueue的操作是同步的，提供锁操作，支持并发的生产者和消费者。

依据使用场景，它可能很有用，也可能有点太大了。通常来说它的基于类接口要比heapq的基于函数的接口更友好。