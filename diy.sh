#!/bin/bash
# ==============================================
# LibWrt 定制脚本 - 京东云亚瑟 RE-SS-01
# 1. 默认后台地址改为 192.168.68.1
# 2. 默认 root 无密码登录
# 3. 默认主题改为 liquid
# ==============================================
set -e

# 1. 修改默认 LAN IP（192.168.1.1 -> 192.168.68.1）
sed -i 's/192\.168\.1\.1/192.168.68.1/g' package/base-files/files/bin/config_generate

# 2. 修改默认 root 密码（无密码登录）
sed -i 's|^root:[^:]*:|root::|' package/base-files/files/etc/shadow

# 3. 设置默认主题为 liquid
mkdir -p files/etc/uci-defaults
cat > files/etc/uci-defaults/99-custom << 'EOF'
#!/bin/sh
uci set luci.main.mediaurlbase='/luci-static/liquid'
uci commit luci
exit 0
EOF
chmod +x files/etc/uci-defaults/99-custom

echo "[diy] customize done"
