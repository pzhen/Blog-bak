---
title: Golang - Delve Mac 安装
toc: true
comments: true
share: true
description: false
date: 2017-12-11 15:12:43
tags:
 - Golang
 - Go
 - Delve
 - 调试
categories:
 - Golang
---

今天 在安装gdb调试工具时，我的mac死活安装不上证书，google上我也没找到解决方案，我只能换了一个调试工具采用了delve，但是结果也很不爽 安装不上，可能是系统升级到 High Sierra的原因，最终从 github上找到一个老外的解决方案，记录在此。<!-- more -->


```
┌─[zhen@bogon] - [~] - [一 12 11, 02:38]
└─[$] <> brew install go-delve/delve/delve
Updating Homebrew...
==> Auto-updated Homebrew!
Updated 1 tap (caskroom/cask).
No changes to formulae.

==> Installing delve from go-delve/delve
==> Downloading https://github.com/derekparker/delve/archive/v1.0.0-rc.2.tar.gz
Already downloaded: /Users/zhen/Library/Caches/Homebrew/delve-1.0.0-rc.2.tar.gz
security: SecKeychainSearchCopyNext: The specified item could not be found in the keychain.
==> Generating dlv-cert
==> openssl req -new -newkey rsa:2048 -x509 -days 3650 -nodes -config dlv-cert.cfg -extensions codesign_reqext -batch -out
==> [SUDO] Installing dlv-cert as root
==> sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain dlv-cert.cer
Last 15 lines from /Users/zhen/Library/Logs/Homebrew/delve/02.sudo:
2017-12-11 14:38:28 +0800

sudo
security
add-trusted-cert
-d
-r
trustRoot
-k
/Library/Keychains/System.keychain
dlv-cert.cer


If reporting this issue please do so at (not Homebrew/brew or Homebrew/core):
https://github.com/go-delve/homebrew-delve/issues

These open issues may also help:
Upgrade to delve fails https://github.com/go-delve/homebrew-delve/issues/20
Delve Install on OSX High Sierra 10.13.1 https://github.com/go-delve/homebrew-delve/issues/24
```

找到issuecomment

```
https://github.com/go-delve/homebrew-delve/issues/19#issuecomment-330442033

下面是其回复：

actually I did this:
cd $HOME/Library/Caches/Homebrew
tar xf delve-*.gz
go into directory ( mine is delve-1.0.0-rc.1 )
sh scripts/gencert.sh

it will asks for password, and you're done.
After that just re run brew install go-delve/delve/delve

and it will pass without problems

```

再次安装

```
brew install go-delve/delve/delve
```

检查是否成功

```
dlv version
```

```
Delve Debugger
Version: 1.0.0-rc.2
Build: v1.0.0-rc.2
```

完美解决，终于将其安装成功。


## 参考资料
> - [security: SecKeychainSearchCopyNext: The specified item could not be found in the keychain.](https://github.com/go-delve/homebrew-delve/issues/19#issuecomment-330442033)

