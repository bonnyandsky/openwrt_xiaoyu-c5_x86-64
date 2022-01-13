[中文](https://p3terx.com/archives/build-openwrt-with-github-actions.html)

./scripts/feeds update helloworld 

./scripts/feeds install -a helloworld

编译步骤：

sudo apt-get update

sudo sh -c "apt update && apt upgrade -y"

sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf wget curl swig rsync

sudo apt install ca-certificates

git clone https://github.com/coolsnowwolf/lede

cd lede

lede\feeds.conf.default添加
```bash
src-git helloworld https://github.com/fw876/helloworld
src-git passwall https://github.com/xiaorouji/openwrt-passwall
```

./scripts/feeds update -a

./scripts/feeds install -a

make menuconfig

make -j8 download V=s 下载dl库（国内请尽量全局科学上网）

find dl -size -1024c -exec ls -l {} \;  列出下载不完整的文件

find dl -size -1024c -exec rm -f {} \;  删除不完整的文件

make -j1 V=s （-j1 后面是线程数。第一次编译推荐用单线程）即可开始编译你要的固件了。

二次编译：

cd lede

git pull

./scripts/feeds update -a && ./scripts/feeds install -a

make defconfig

make -j8 download

make -j$(($(nproc) + 1)) V=s

如果需要重新配置：

rm -rf ./tmp && rm -rf .config

make menuconfig

make -j$(($(nproc) + 1)) V=s

编译完成后输出路径：bin/targets

如果你使用WSL或WSL2进行编译：
由于wsl的PATH路径中包含带有空格的Windows路径，有可能会导致编译失败，请在将make -j1 V=s或make -j$(($(nproc) + 1)) V=s改为

首次编译：

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin make -j1 V=s
二次编译：

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin make -j$(($(nproc) + 1)) V=s
