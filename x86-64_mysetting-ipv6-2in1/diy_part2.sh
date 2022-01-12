#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.0.1/g' package/base-files/files/bin/config_generate

# 删除默认密码 第二条可以起作用，但是在immortalwrt不起作用。第一条可以用于immortalwrt
#sed -i '34s/sed/# sed/g' package/lean/default-settings/files/zzz-default-settings
sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings

# 移除重复软件包
rm -rf package/lean/luci-theme-argon
rm -rf package/lean/luci-app-netdata
rm -rf package/lean/luci-app-wrtbwmon

# 添加额外软件包，不在根目录要用svn co，然后tree/main替换成trunk
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-advanced package/luci-app-advanced
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-eqos package/luci-app-eqos
git clone https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata package/luci-app-netdata
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netspeedtest package/luci-app-netspeedtest

# 流量监控
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-wrtbwmon package/luci-app-wrtbwmon
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/wrtbwmon package/wrtbwmon

# Themes
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

# 修改插件名字
sed -i 's/"流量"/"实时流量监测"/g' `grep "流量" -rl ./`

./scripts/feeds update -a
./scripts/feeds install -a
