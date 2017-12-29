---
title: Golang - 指针
toc: true
comments: true
share: true
date: 2017-11-17 15:27:20
tags:
 - Golang
 - 指针
 - Go
categories:
 - Golang
---

## Go 语言指针


Go 语言中指针是很容易学习的，Go 语言中使用指针可以更简单的执行一些任务。
接下来让我们来一步步学习 Go 语言指针。
我们都知道，变量是一种使用方便的占位符，用于引用计算机内存地址。
Go 语言的取地址符是 &，放到一个变量前使用就会返回相应变量的内存地址。
以下实例演示了变量在内存中地址：

``` golang
package main

import "fmt"

func main() {
   var a int = 10   

   fmt.Printf("变量的地址: %x\n", &a  )
}
```
<!-- more -->

执行以上代码输出结果为：

```
变量的地址: 20818a220
```

现在我们已经了解了什么是内存地址和如何去反问它。接下来我们将具体介绍指针。

## 什么是指针
一个指针变量可以指向任何一个值的内存地址它指向那个值的内存地址。
类似于变量和常量，在使用指针前你需要声明指针。指针声明格式如下：
```
var var_name *var-type
```

var-type 为指针类型，var_name 为指针变量名，* 号用于指定变量是作为一个指针。以下是有效的指针声明：

```
var ip *int        /* 指向整型*/
var fp *float32    /* 指向浮点型 */
```

本例中这是一个指向 int 和 float32 的指针。

## 如何使用指针

指针使用流程：

 - 定义指针变量。
 - 为指针变量赋值。
 - 访问指针变量中指向地址的值。

在指针类型前面加上 * 号（前缀）来获取指针所指向的内容。

``` golang
package main

import "fmt"

func main() {
   var a int= 20   /* 声明实际变量 */
   var ip *int        /* 声明指针变量 */

   ip = &a  /* 指针变量的存储地址 */

   fmt.Printf("a 变量的地址是: %x\n", &a  )

   /* 指针变量的存储地址 */
   fmt.Printf("ip 变量的存储地址: %x\n", ip )

   /* 使用指针访问值 */
   fmt.Printf("*ip 变量的值: %d\n", *ip )
}
```

以上实例执行输出结果为：

```
a 变量的地址是: 20818a220
ip 变量的存储地址: 20818a220
*ip 变量的值: 20
```

## Go 空指针
当一个指针被定义后没有分配到任何变量时，它的值为 nil。
nil 指针也称为空指针。
nil在概念上和其它语言的null、None、nil、NULL一样，都指代零值或空值。
一个指针变量通常缩写为 ptr。
查看以下实例：
``` golang
package main

import "fmt"

func main() {
   var  ptr *int

   fmt.Printf("ptr 的值为 : %x\n", ptr  )
}
```
以上实例输出结果为：
```
ptr 的值为 : 0
```
空指针判断：
``` go
if(ptr != nil)     /* ptr 不是空指针 */
if(ptr == nil)    /* ptr 是空指针 */
```

## Go指针更多内容
接下来我们将为大家介绍Go语言中更多的指针应用

|内容|描述|
|---|----|
|[Go 指针数组](http://www.runoob.com/go/go-array-of-pointers.html)|	你可以定义一个指针数组来存储地址|
|[Go 指向指针的指针](http://www.runoob.com/go/go-pointer-to-pointer.html)|	Go 支持指向指针的指针|
|[Go 像函数传递指针参数](http://www.runoob.com/go/go-passing-pointers-to-functions.html)|	通过引用或地址传参，在函数调用时可以改变其值|



### Go 指针数组
在我们了解指针数组前，先看个实例，定义了长度为 3 的整型数组：
```go
package main

import "fmt"

const MAX int = 3

func main() {

   a := []int{10,100,200}
   var i int

   for i = 0; i < MAX; i++ {
      fmt.Printf("a[%d] = %d\n", i, a[i] )
   }
}
```
以上代码执行输出结果为：

```
a[0] = 10
a[1] = 100
a[2] = 200
```

有一种情况，我们可能需要保存数组，这样我们就需要使用到指针。
以下声明了整型指针数组：
```
var ptr [MAX]*int;
```
ptr 为整型指针数组。因此每个元素都指向了一个值。以下实例的三个整数将存储在指针数组中：
```go
package main

import "fmt"

const MAX int = 3

func main() {
   a := []int{10,100,200}
   var i int
   var ptr [MAX]*int;

   for  i = 0; i < MAX; i++ {
      ptr[i] = &a[i] /* 整数地址赋值给指针数组 */
   }

   for  i = 0; i < MAX; i++ {
      fmt.Printf("a[%d] = %d\n", i,*ptr[i] )
   }
}
```
以上代码执行输出结果为：
```
a[0] = 10
a[1] = 100
a[2] = 200
```

如果一个指针变量存放的又是另一个指针变量的地址，则称这个指针变量为指向指针的指针变量。
当定义一个指向指针的指针变量时，第一个指针存放第二个指针的地址，第二个指针存放变量的地址：

![](http://static.golangtab.com/images/2017-11/pointer_to_pointer.jpg)

指向指针的指针变量声明格式如下：
```go
var ptr **int;
```
以上指向指针的指针变量为整型。
访问指向指针的指针变量值需要使用两个 * 号，如下所示：
```
package main

import "fmt"

func main() {

   var a int
   var ptr *int
   var pptr **int

   a = 3000

   /* 指针 ptr 地址 */
   ptr = &a

   /* 指向指针 ptr 地址 */
   pptr = &ptr

   /* 获取 pptr 的值 */
   fmt.Printf("变量 a = %d\n", a )
   fmt.Printf("指针变量 *ptr = %d\n", *ptr )
   fmt.Printf("指向指针的指针变量 **pptr = %d\n", **pptr)
}
```
以上实例执行输出结果为：
```
变量 a = 3000
指针变量 *ptr = 3000
指向指针的指针变量 **pptr = 3000
```

### Go 像函数传递指针参数
Go 语言允许向函数传递指针，志需要在函数定义的参数上设置为指针类型即可。
以下实例演示了如何向函数传递指针，并在函数调用后修改函数内的值，：

```
package main

import "fmt"

func main() {
   /* 定义局部变量 */
   var a int = 100
   var b int= 200

   fmt.Printf("交换前 a 的值 : %d\n", a )
   fmt.Printf("交换前 b 的值 : %d\n", b )

   /* 调用函数用于交换值
   * &a 指向 a 变量的地址
   * &b 指向 b 变量的地址
   */
   swap(&a, &b);

   fmt.Printf("交换后 a 的值 : %d\n", a )
   fmt.Printf("交换后 b 的值 : %d\n", b )
}

func swap(x *int, y *int) {
   var temp int
   temp = *x    /* 保存 x 地址的值 */
   *x = *y      /* 将 y 赋值给 x */
   *y = temp    /* 将 temp 赋值给 y */
}
```

以上实例允许输出结果为：

```
交换前 a 的值 : 100
交换前 b 的值 : 200
交换后 a 的值 : 200
交换后 b 的值 : 100
```