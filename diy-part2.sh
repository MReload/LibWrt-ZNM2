#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/172.16.1.1/g' package/base-files/files/bin/config_generate

# Modify default hostname
#sed -i "s/hostname='.*'/hostname='OpenWrt'/g" package/base-files/files/bin/config_generate

# ============================================
# NSS q6_region 内存调整（无 WiFi 版本）
# ============================================
# 默认值: 55MB (0x3700000)
# 无 WiFi 版本可减少到 16MB，释放更多内存给系统
DTS_FILE="target/linux/qualcommax/files/arch/arm64/boot/dts/qcom/ipq6018-512m.dtsi"
if [ -f "$DTS_FILE" ]; then
    sed -i 's/reg = <0x0 0x4ab00000 0x0 0x[0-9a-f]\+>/reg = <0x0 0x4ab00000 0x0 0x01000000>/' "$DTS_FILE"
    echo "q6_region memory adjusted to 16MB for NoWiFi"
fi

# ============================================
# NoWiFi DTS 调整
# ============================================
# 将 WiFi 相关 DTS 引用改为 nowifi 版本
DTS_PATH="target/linux/qualcommax/files/arch/arm64/boot/dts/qcom/"
if [ -d "$DTS_PATH" ]; then
    find "$DTS_PATH" -type f ! -iname '*nowifi*' -exec sed -i 's/ipq\(6018\|8074\).dtsi/ipq\1-nowifi.dtsi/g' {} +
    echo "NoWiFi DTS configured"
fi
