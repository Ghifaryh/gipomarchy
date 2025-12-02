#!/bin/bash
# Run as root: sudo bash optimize.sh

echo "Starting system optimization..."

# -----------------------------
# 1. ZRAM setup (keep 50% RAM)
# -----------------------------
echo "Configuring ZRAM..."
modprobe zram
echo 0 > /sys/block/zram0/reset 2>/dev/null
echo $((8*1024/2))M > /sys/block/zram0/disksize  # 50% of 8GB RAM
mkswap /dev/zram0
swapon /dev/zram0 -p 100
echo "ZRAM setup done."

# -----------------------------
# 2. Swapfile fallback (on Btrfs)
# -----------------------------
SWAPFILE=/swap/swapfile
mkdir -p /swap
chattr +C /swap 2>/dev/null
fallocate -l 2G $SWAPFILE
chmod 600 $SWAPFILE
mkswap $SWAPFILE
swapon $SWAPFILE -p -2
echo "Swapfile setup done."

# -----------------------------
# 3. Sysctl tuning
# -----------------------------
echo "Setting sysctl parameters..."
cat <<EOF > /etc/sysctl.d/99-optimized.conf
vm.swappiness=20
vm.vfs_cache_pressure=50
vm.dirty_ratio=15
vm.dirty_background_ratio=5
fs.inotify.max_user_instances=1024
fs.inotify.max_user_watches=524288
vm.max_map_count=1048576
EOF
sysctl --system

# -----------------------------
# 4. Inotify / file watchers (Docker, coding)
# -----------------------------
echo "Ensuring Docker/coding friendly limits..."
sysctl -w fs.inotify.max_user_watches=524288
sysctl -w fs.inotify.max_user_instances=1024

# -----------------------------
# 5. Enable fstrim timer for SSD
# -----------------------------
echo "Enabling weekly fstrim..."
systemctl enable --now fstrim.timer

# -----------------------------
# 6. Ensure power-profiles-daemon enabled
# -----------------------------
echo "Checking power profile..."
systemctl enable --now power-profiles-daemon

# -----------------------------
# 7. Optional: tuning NVMe & CPU (already in kernel cmdline)
# -----------------------------
echo "NVMe power and CPU pstate already active via kernel cmdline."
echo "If you want, use 'powerprofilesctl set balanced' for normal usage."

echo "✅ System optimization complete!"
