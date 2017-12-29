---
title: Javascript - 截取字符串
toc: true
comments: true
share: true
date: 2017-08-15 14:48:39
tags:
 - javascript
 - js
 - split
categories:
 - Javascript
---
str.split("xxx")<!-- more -->

``` html
<input type="hidden" value='' id="bgimgid">
<script>
	var str = '/app/upload/image/survey/bg476.jpg';
	var arr = new Array();
	arr = str.split("/");
	if(arr.length > 1){
		var result = arr[arr.length-2];
		document.getElementById("bgimgid").value = result;
	}
</script>
```


