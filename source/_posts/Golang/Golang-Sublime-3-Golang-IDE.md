---
title: Golang - Sublime 3 Golang IDE
toc: true
comments: true
share: true
date: 2017-11-13 18:19:52
tags:
 - Golang
 - Sublime
 - Go
categories:
 - Golang
---

### 安装golnag

首先到（https://golang.org/dl）

选择适合你系统的安装包，

首先安装好golang。(命令:go env)查看环境。<!-- more -->


### 安装 sublime text3

首先也是下载：[http://www.sublimetext.com/3](http://www.sublimetext.com/3)，安装也很傻瓜，直接下一步即可。


 这里需要安装一个sublime的pakcage control功能，用于接下来安装sublime插件。

1）在打开软件后，按下快捷键 Ctrl+`，（`这个符号为英文半角模式下，按下 Tab 键上方、数字键1左边的那个按键），此时会打开一个命令窗口，复制并输入以下内容，最后回车：


```
import urllib.request,os,hashlib; h = 'eb2297e1a458f27d836c04bb0cbaf282' + 'd0e7a3098092775ccb37ca9d6b2e4b7d'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
```


2）重启sublime之后，你就可以发现在 Preferences 这个菜单下出现了菜单项 Package Control，如图：

![](http://static.golangtab.com/images/2017-10/1432355012.png)

3)在sublime中，按住快捷键 shift + ctrl + p，在弹出框中输入install package，如图：

![](http://static.golangtab.com/images/2017-10/1432353394.png)

4）回车，会出现如下图（可能需要稍微等待下，可以看sublime最下面的状态）：

![](http://static.golangtab.com/images/2017-10/1432353546.png)

5)输入gosublime，回车（可能需要稍微等待下，可以看sublime最下面的状态），如图：

![](http://static.golangtab.com/images/2017-10/1432353719.png)

6）gosublime安装完成后，Preferences -> package settings -> GoSublime -> Settings - Uesrs需要配置下GOPATH，GOROOT，如图：

![](http://static.golangtab.com/images/2017-10/1432354244.png)

7）在打开的窗口中输入以下内容，路径请自行替换，ctrl+s保存。

```
{
    "env": {
        "GOPATH": "F:/mygo",
        "GOROOT": "E:/Go"
    }
}
```

8）重启sublime，在GOPATH中的src新建一个hello.go文件，可以看到代码自动补全已经出来了，:)

![](http://static.golangtab.com/images/2017-10/1432354894.png)

至此，sublime text3 + golang 安装完成。



附上我的 sublime text3 的简单配置, Preferences -> Settings User清空复制粘贴即可。
```
{
    "font_size": 12,
    "highlight_line": true,
    "highlight_modified_tabs": true,
    "ignored_packages":
    [
        "Vintage"
    ],
    "soda_classic_tabs": true,
    "soda_folder_icons": true,
    "tab_size": 4,
    "translate_tabs_to_spaces": true,
    "update_check": false,
    "word_wrap": true
}
```

## 参考资料
> - [Sublime Text3 + Golang搭建开发环境](https://studygolang.com/articles/4454)
