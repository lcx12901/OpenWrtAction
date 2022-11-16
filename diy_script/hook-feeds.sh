#!/bin/bash
#=================================================
# File name: hook-feeds.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: SuLingGG
# Blog: https://mlapp.cn
#=================================================
# Svn checkout packages from immortalwrt's repository

git clone --depth=1 https://github.com/DHDAXCW/packages customfeeds/packages
git clone --depth=1 https://github.com/DHDAXCW/luci customfeeds/luci


pushd customfeeds

# Add luci-app-gowebdav
svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-gowebdav luci/applications/luci-app-gowebdav
svn co https://github.com/immortalwrt/packages/trunk/net/gowebdav packages/net/gowebdav

# Replace smartdns with the official version
# rm -rf packages/net/smartdns
# svn co https://github.com/openwrt/packages/trunk/net/smartdns packages/net/smartdns
popd

# Set to local feeds
pushd customfeeds/packages
export packages_feed="$(pwd)"
popd
pushd customfeeds/luci
export luci_feed="$(pwd)"
popd
sed -i '/src-git packages/d' feeds.conf.default
echo "src-link packages $packages_feed" >> feeds.conf.default
sed -i '/src-git luci/d' feeds.conf.default
echo "src-link luci $luci_feed" >> feeds.conf.default

# Clone community packages
mkdir package/community
pushd package/community

# Add Lienol's Packages
git clone --depth=1 https://github.com/Lienol/openwrt-package
rm -rf openwrt-package/verysync
rm -rf openwrt-package/luci-app-verysync

# Add luci-app-poweroff
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff

# Add OpenClash
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash

# Add luci-app-unblockneteasemusic
rm -rf ../../customfeeds/luci/applications/luci-app-unblockmusic
git clone --depth=1 https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git

# Add luci-theme
git clone https://github.com/DHDAXCW/theme
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git

# Add luci-aliyundrive-webdav
rm -rf ../../customfeeds/luci/applications/luci-app-aliyundrive-webdav 
rm -rf ../../customfeeds/luci/applications/aliyundrive-webdav
svn co https://github.com/messense/aliyundrive-webdav/trunk/openwrt/aliyundrive-webdav
svn co https://github.com/messense/aliyundrive-webdav/trunk/openwrt/luci-app-aliyundrive-webdav
popd
