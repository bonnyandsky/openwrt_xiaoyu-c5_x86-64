[中文](https://p3terx.com/archives/build-openwrt-with-github-actions.html)

#添加2条命令到feeds.conf.default
src-git helloworld https://github.com/fw876/helloworld
src-git passwall https://github.com/xiaorouji/openwrt-passwall

#执行命令安装对应feeds
  ./scripts/feeds update helloworld
  ./scripts/feeds install -a -p helloworld
  ./scripts/feeds update passwall
  ./scripts/feeds install -a -p passwall
 
