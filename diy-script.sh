#!/bin/bash
#===============================================
# Description: DIY script
# File name: diy-script.sh
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#===============================================

# 修改默认IP
# sed -i 's/192.168.1.1/10.10.10.10/g' package/base-files/files/bin/config_generate

# Autocoresed -i 's/192.168.1.1/192.168.50.254/g' package/base-files/files/bin/config_generate

sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=1000000' package/base-files/files/etc/sysctl.conf
sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile
sed -i '/customized in this file/a net.core.somaxconn=65536' package/base-files/files/etc/sysctl.conf
sed -i '/customized in this file/a net.ipv4.udp_wmem_min=6553500' package/base-files/files/etc/sysctl.conf
sed -i '/customized in this file/a net.ipv4.udp_rmem_min=6553600' package/base-files/files/etc/sysctl.conf
sed -i '/customized in this file/a net.core.rmem_max=40960000' package/base-files/files/etc/sysctl.conf
sed -i '/customized in this file/a net.core.wmem_max=40960000' package/base-files/files/etc/sysctl.conf
sed -i '/customized in this file/a net.core.wmem_default=40960000' package/base-files/files/etc/sysctl.conf
sed -i '/customized in this file/a net.core.rmem_default=40960000' package/base-files/files/etc/sysctl.conf
sed -i '/customized in this file/a net.ipv4.tcp_mem="65535        4638400   64943040"' package/base-files/files/etc/sysctl.conf
sed -i '/customized in this file/a net.ipv4.udp_mem="65535        4638400   64943040"' package/base-files/files/etc/sysctl.conf
sed -i '/customized in this file/a net.ipv4.tcp_rmem="65535        4638400   64943040"' package/base-files/files/etc/sysctl.conf
sed -i '/customized in this file/a net.ipv4.tcp_wmem="65535        4638400   64943040"' package/base-files/files/etc/sysctl.conf

# Cpufreq
sed -i 's/services/system/g' feeds/luci/applications/luci-app-cpufreq/luasrc/controller/cpufreq.lua

# 移除重复软件包
rm -rf feeds/packages/net/mosdns
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/themes/luci-theme-netgear
rm -rf feeds/luci/applications/luci-app-netdata
rm -rf feeds/luci/applications/luci-app-wrtbwmon
rm -rf feeds/luci/applications/luci-app-dockerman

# 添加额外软件包
git clone https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
git clone https://github.com/riverscn/openwrt-iptvhelper.git package/openwrt-iptvhelper
git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr
git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
git clone https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-filebrowser package/luci-app-filebrowser
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-smartdns package/luci-app-smartdns


# 科学上网插件依赖
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
# 编译 po2lmo (如果有po2lmo可跳过)
make && sudo make install
popd
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/brook package/brook
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/tcping package/tcping
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/hysteria package/hysteria
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/dns2tcp package/dns2tcp
svn co https://github.com/fw876/helloworld/trunk/sagernet-core package/sagernet-core
svn co https://github.com/fw876/helloworld/trunk/simple-obfs package/simple-obfs
svn co https://github.com/fw876/helloworld/trunk/lua-neturl package/lua-neturl
svn co https://github.com/fw876/helloworld/trunk/trojan package/trojan

# Themes
git clone -b 18.06 https://github.com/kiddin9/luci-theme-edge package/luci-theme-edge
svn co https://github.com/rosywrt/luci-theme-rosy/trunk/luci-theme-rosy package/luci-theme-rosy
svn co https://github.com/haiibo/packages/trunk/luci-theme-atmaterial_new package/luci-theme-atmaterial_new
svn co https://github.com/haiibo/packages/trunk/luci-theme-opentomcat package/luci-theme-opentomcat
svn co https://github.com/haiibo/packages/trunk/luci-theme-netgear package/luci-theme-netgear
git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
git clone https://github.com/thinktip/luci-theme-neobird package/luci-theme-neobird

# 晶晨宝盒
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic
sed -i "s|https.*/OpenWrt|https://github.com/haiibo/OpenWrt|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|opt/kernel|https://github.com/ophub/kernel/tree/main/pub/stable|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|ARMv8|ARMv8_PLUS|g" package/luci-app-amlogic/root/etc/config/amlogic

# MosDNS
svn co https://github.com/QiuSimons/openwrt-mos/trunk/luci-app-mosdns package/luci-app-mosdns
svn co https://github.com/QiuSimons/openwrt-mos/trunk/mosdns package/mosdns

# DDNS.to
svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-ddnsto package/luci-app-ddnsto
svn co https://github.com/linkease/nas-packages/trunk/network/services/ddnsto package/ddnsto

# 流量监控
svn co https://github.com/haiibo/packages/trunk/luci-app-wrtbwmon package/luci-app-wrtbwmon
svn co https://github.com/haiibo/packages/trunk/wrtbwmon package/wrtbwmon

# 在线用户
svn co https://github.com/haiibo/packages/trunk/luci-app-onliner package/luci-app-onliner
sed -i '/bin\/sh/a\uci set nlbwmon.@nlbwmon[0].refresh_interval=2s' package/lean/default-settings/files/zzz-default-settings
sed -i '/nlbwmon/a\uci commit nlbwmon' package/lean/default-settings/files/zzz-default-settings

# 修改版本为编译日期
date_version=$(date +"%Y.%m.%d")
orig_version=$(echo "$(cat package/lean/default-settings/files/zzz-default-settings)" | grep -Po "DISTRIB_REVISION=\'\K[^\']*")
sed -i "s/${orig_version}/R${date_version}/g" package/lean/default-settings/files/zzz-default-settings

# 调整 x86 只显示 CPU 型号
sed -i '/h=${g}.*/d' package/lean/autocore/files/x86/autocore
sed -i 's/(dmesg.*/{a}${b}${c}${d}${e}${f}/g' package/lean/autocore/files/x86/autocore
sed -i 's/echo $h/echo $g/g' package/lean/autocore/files/x86/autocore

# 修改 Makefile
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/include\ \.\.\/\.\.\/luci\.mk/include \$(TOPDIR)\/feeds\/luci\/luci\.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/include\ \.\.\/\.\.\/lang\/golang\/golang\-package\.mk/include \$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang\-package\.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=\@GHREPO/PKG_SOURCE_URL:=https:\/\/github\.com/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=\@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload\.github\.com/g' {}

# 调整 V2ray服务器 到 VPN 菜单

./scripts/feeds update -a
./scripts/feeds install -a
