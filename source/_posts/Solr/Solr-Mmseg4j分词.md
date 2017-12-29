---
title: Solr - Mmseg4j分词
toc: true
date: 2017-08-01 15:30:25
share: true
tags:
 - Solr
 - Mmseg4j
categories:
 - Solr
---

```xml
<fieldtype name="textComplex" class="solr.TextField" positionIncrementGap="100">
    <analyzer>
        <tokenizer class="com.chenlb.mmseg4j.solr.MMSegTokenizerFactory" mode="complex" dicPath="/Users/zhen/opt/solr-5.5.3/server/solr/comic/conf/dic/" />
    	<filter class="solr.StopFilterFactory" ignoreCase="true" words="/Users/zhen/opt/solr-5.5.3/server/solr/comic/conf/stopwords.txt" />
    </analyzer>
</fieldtype>

<!--
<fieldtype name="textMaxWord" class="solr.TextField" positionIncrementGap="100">
    <analyzer>
        <tokenizer class="com.chenlb.mmseg4j.solr.MMSegTokenizerFactory" mode="max-word" />
    </analyzer>
</fieldtype>
<fieldtype name="textSimple" class="solr.TextField" positionIncrementGap="100">
    <analyzer>
        <tokenizer class="com.chenlb.mmseg4j.solr.MMSegTokenizerFactory" mode="simple" dicPath="n:/custom/path/to/my_dic" />
    </analyzer>
</fieldtype>
-->
```
