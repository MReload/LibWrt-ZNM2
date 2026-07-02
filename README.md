# MyOpenWrt-CI

基于 [P3TERX/Actions-OpenWrt](https://github.com/P3TERX/Actions-OpenWrt) 模板的个人 OpenWrt 云编译项目。

## 固件信息

| 项目 | 内容 |
|------|------|
| **设备** | 兆能 M2 (IPQ60XX) |
| **源码** | [LiBwrt/LibWrt](https://github.com/LiBwrt/LibWrt) |
| **分支** | main-nss |
| **内核** | 6.12 |
| **NSS** | ✅ 已启用 (v12.5) |
| **WiFi** | ❌ 无 WiFi 版本 |

## 默认配置

| 配置 | 值 |
|------|-----|
| **IP 地址** | 172.16.1.1 |
| **密码** | 无 |

## 内置插件

- luci-app-autoreboot - 定时重启
- luci-app-firewall - 防火墙
- luci-app-package-manager - 软件包管理
- luci-theme-bootstrap - Bootstrap 主题

## NoWiFi 优化

此固件为无 WiFi 版本，已做以下优化：

1. **禁用 ath11k 驱动和固件** - 减少固件体积
2. **q6_region 内存调整** - 从 55MB 减少到 16MB，释放更多系统内存
3. **NSS 固件版本** - 使用 v12.5 版本

## 使用方法

1. Fork 此仓库
2. 修改 `.config` 文件（可选）
3. 修改 `diy-part2.sh` 中的默认 IP（可选）
4. 进入 Actions 页面，点击 `Build OpenWrt` 运行工作流
5. 编译完成后在 Releases 下载固件

## 自定义

### 修改默认 IP

编辑 `diy-part2.sh`，修改：
```bash
sed -i 's/192.168.1.1/你的IP/g' package/base-files/files/bin/config_generate
```

### 调整 q6_region 内存

编辑 `diy-part2.sh`，修改内存大小：
```bash
# 16MB (推荐无 WiFi)
sed -i 's/reg = <0x0 0x4ab00000 0x0 0x[0-9a-f]\+>/reg = <0x0 0x4ab00000 0x0 0x01000000>/'

# 32MB
sed -i 's/reg = <0x0 0x4ab00000 0x0 0x[0-9a-f]\+>/reg = <0x0 0x4ab00000 0x0 0x02000000>/'

# 64MB
sed -i 's/reg = <0x0 0x4ab00000 0x0 0x[0-9a-f]\+>/reg = <0x0 0x4ab00000 0x0 0x04000000>/'
```

### 添加插件

编辑 `.config` 文件，添加：
```
CONFIG_PACKAGE_luci-app-xxx=y
```

## 致谢

- [P3TERX/Actions-OpenWrt](https://github.com/P3TERX/Actions-OpenWrt)
- [LiBwrt/LibWrt](https://github.com/LiBwrt/LibWrt)
- [laipeng668/openwrt-ci-roc](https://github.com/laipeng668/openwrt-ci-roc)
- [OpenWrt](https://github.com/openwrt/openwrt)
- [ImmortalWrt](https://github.com/immortalwrt/immortalwrt)

## License

MIT © [P3TERX](https://p3terx.com)
