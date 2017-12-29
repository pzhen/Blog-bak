---
title: Composer - 管理PHP依赖
toc: true
date: 2017-07-21 17:32:30
tags:
 - Composer
 - Php
categories:
 - Composer
share: true
---

PHP依赖的管理。<!-- more -->

#### 简介

现在软件规模越来越大，PHP项目的开发模式和许多年前已经有了很大变化。记得初学PHP那会儿，boblog是一个很好的例子，几乎可以代表 PHP项目的开发模式。当时PHP 5.x以上的版本刚开始流行，仍然有大量的生产环境使用PHP4.x。由于历史遗留的问题，OOP思想在PHP项目中还不是那么广泛流行。随着 PHP5.3的发布，PHP项目规模的扩大，在其他语言领域大展身手的OOP开发模式也在PHP中崭露头角。
<!-- more -->
大型项目不可能是从头开始的，使用社区已经提供的资源可以为项目带来很大的便利。然而各自为政的打包方式、依赖关系的处理，导致了很难将两个开源项 目集成到一起。虽然有pear这种PHP官方支持的包管理工具，但是依然没有很好的统一的依赖关系管理的办法。直到Composer的出现。

Composer的依赖关系管理风格，看上去更像Java的Maven。项目编译和打包、依赖关系的解决都可以很轻松的实现。再也不用费神去寻找或者更新第三方库，或者将他们集成到一起。这一切全部都可以交给Composer来完成。

 
#### 例子

首先来看一个类似于Helloworld的例子，让我们对Composer先有一个感性的认识吧。

如何在一个PHP项目中启用Composer，很简单，只需要在项目根目录中创建一个composer.json文件即可，它包含如下内容：
```
{
        "require": {
	        "monolog/monolog": "1.2.*"
	 }
}
```
这样我们便添加了对monolog这个库的引用。没错，就是这样简单。不过，你还需要使用composer来为你更新依赖包，打开你的Shell，切换到项目目录下执行：
```
composer install
```
这时，Composer便自动从互联网上更新指定依赖的库了。你会发现你的项目文件夹里面多了一个vendor文件夹，那就是依赖库包了。

接下来，你需要在你的系统的公共入口文件中引用自动加载器，以便自动加载类：
``` php
require 'vendor/autoload.php';
```

#### 安装

上面的例子让大家对composer的使用有了一个大概的认识。下面将向大家介绍如何在PHP环境中安装composer。
Unix/Linux/OSX环境

很幸运，利用Unix Like环境安装composer是一件很简单的事情。只需要一行命令：
```
curl -sS https://getcomposer.org/installer | php
```
此时会为你在当前工作目录安装composer.phar文件，使用php composer.phar即可运行。当然，你可能更想让composer变成像其他一样的Unix命令，很简单，只需要再加一步：
```
mv composer.phar /usr/local/bin/composer
```
注意，在权限受限的系统上，你可能需要使用sudo命令来提升至管理员账号执行。

这时，你就可以像例子里面那样使用composer了。
Windows环境

Composer官方推荐使用安装包进行安装，据说下载Composer-Setup.exe这个即可用向导模式安装。

关于手工安装的方法，请参考http://getcomposer.org/doc/00-intro.md的介绍吧。

#### 自动加载

为了实现PHP类的随取随用，类的命名空间定义建议遵从一定的规则。这种规则可以是某一项目组约定的。不过为了使得类库统一，PHP-FIG项目指 定了一种PHP命名空间的规范PSR-0，被一些流行PHP项目采用。Composer支持这种规范的类库自动装载器，只需要向 composer.json文件中添加autoload节点即可：
```
{
	    "autoload": {
	        "psr-0": {"Acme\\": "src/"}
	    }
}
```
关于PSR-0规范，有这么几点重要的要求：

- 命名空间规范参考：\<Vendor Name>\(<Namespace>\)*<Class Name>
- 每个namespace需要一个顶层空间，即vendor name。用来指定在软件包级别上区别。
- 命名空间和PHP文件的路径是一一对应的，最终命名空间分隔符会被转为DIRECTORY_SEPARATOR
- 文件名必须为类名.php

关于这个规范，可以参考http://blog.mosil.biz/2012/08/psr-0-autoloading-standard/这篇文章。有关PSR-0的更多内容，可以参考他们的官方网站：https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-0.md

注意，修改了autoload后，要重新使用composer install。

注意：composer默认类库是使用PSR-0规范自动加载的。所以一般无需额外配置。

#### 查找所需类库

composer提供了一个类库的“商店”，在这里，你可以立即找到想要使用的开源类库包，然后把他们添加到你的项目中即可。传送门：https://packagist.org/

#### 打包自己的类库

将自己的类库贡献给大家，首先需要为自己的类库设置打包信息（要首先保证自己的类库是利用composer管理的）。在composer.json文件中设置：
```
	{
	    "name": "your-vendor-name/package-name",
	    "require": {
	        "php": ">=5.3.0",
	        "another-vendor/package": "1.*"
	    }
	}
```
然后就可以前去https://packagist.org/提交你的类库了。


## 参考资料
> - [快速入门](http://getcomposer.org/doc/00-intro.md)
> - [文档](http://getcomposer.org/doc/)
> - [包列表](https://packagist.org/)
