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
git clone https://github.com/sirpdboy/luci-app-advanced
cp -r luci-app-advanced package/luci-app-advanced

# git clone https://github.com/sirpdboy/luci-app-advanced package/luci-app-advanced
# git clone https://github.com/sirpdboy/netspeedtest package/netspeedtest
# git clone https://github.com/sirpdboy/luci-app-netdata package/luci-app-netdata
# cp -r package/luci-app-netdata package/lean/
