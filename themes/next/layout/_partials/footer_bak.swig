
<span id="showDays"></span>

{% if theme.footer.powered_info %}

<div class="copyright">{#
#}{% set current = date(Date.now(), "YYYY") %}{#
#}&copy; {% if theme.footer.since and theme.footer.since != current %}{{ theme.footer.since }} &mdash; {% endif %}{#
#}<span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-{{ theme.footer.icon }}"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ theme.footer.copyright || config.author }}</span>

  {% if theme.post_wordcount.totalcount %}
    <span class="post-meta-divider">|</span>
    <span class="post-meta-item-icon">
      <i class="fa fa-area-chart"></i>
    </span>
    {% if theme.post_wordcount.item_text %}
      <span class="post-meta-item-text">{{ __('post.totalcount') }}&#58;</span>
    {% endif %}
    <span title="{{ __('post.totalcount') }}">{#
    #}{{ totalcount(site, '0,0.0a') }}{#
  #}</span>
  {% endif %}
</div>





{% if theme.footer.powered %}
  <div class="powered-by">{#
  #}{{ __('footer.powered', '<a class="theme-link" style="color: #999;" target="_blank" href="https://hexo.io">Hexo</a>') }}{#
#}</div>
{% endif %}

{% if theme.footer.powered and theme.footer.theme.enable %}
  <span class="post-meta-divider">|</span>
{% endif %}


托管 — <a class="" target="_blank" style="color: #999;" href="https://www.aliyun.com/">阿里云</a>
<span class="post-meta-divider">|</span>

加速 — <a class="theme-link" target="_blank" style="color: #999;" href="https://www.qiniu.com">七牛云</a>
<span class="post-meta-divider">|</span>


{% if theme.footer.theme.enable %}
  <div class="theme-info">{#
  #}{{ __('footer.theme') }} &mdash; {#
  #}<a class="theme-link" target="_blank" style="color: #999;" href="https://github.com/iissnan/hexo-theme-next">{#
    #}NexT.{{ theme.scheme }}{#
  #}</a>{% if theme.footer.theme.version %} v{{ theme.version }}{% endif %}{#
#}</div>
{% endif %}

<span class="post-meta-divider">|</span>
统计 — <a class="theme-link" target="_blank" style="color: #999;" href="http://busuanzi.ibruce.info/">不蒜子</a>


{% endif %}

{% if theme.footer.custom_text %}
  <div class="footer-custom">{#
  #}{{ theme.footer.custom_text }}{#
#}</div>
{% endif %}

<script>var seconds=1e3,minutes=60*seconds,hours=60*minutes,days=24*hours,years=365*days,birthDay=Date.UTC(2017,3,25,0,0,0);setInterval(function(){var e=new Date,s=e.getFullYear(),t=e.getMonth()+1,a=e.getDate(),o=e.getHours(),r=e.getMinutes(),n=e.getSeconds(),h=Date.UTC(s,t,a,o,r,n),u=h-birthDay,d=Math.floor(u/years),y=Math.floor(u/days-365*d),i=Math.floor((u-(365*d+y)*days)/hours),l=Math.floor((u-(365*d+y)*days-i*hours)/minutes),M=Math.floor((u-(365*d+y)*days-i*hours-l*minutes)/seconds);document.getElementById("showDays").innerHTML="本站已运行 "+d+" 年 "+y+" 天 "+i+" 小时 "+l+" 分钟 "+M+" 秒"},1e3)</script>