#!/usr/bin/env bash
# reset-dns.sh — show DNS status before/after restarting systemd-resolved
# Usage:
#   ./reset-dns.sh                 # auto-detect default interface
#   ./reset-dns.sh enp4s0f3u1u4c2  # or specify interface explicitly

set -euo pipefail

LINK="${1:-}"

# Try to auto-detect the default-route interface if not provided
if [[ -z "${LINK}" ]]; then
  if command -v ip >/dev/null 2>&1; then
    LINK="$(ip route show default 2>/dev/null | awk '/default/ {print $5; exit}')"
  fi
fi
LINK="${LINK:-enp4s0f3u1u4c2}"

print_status () {
  echo "========== GLOBAL =========="
  resolvectl status | sed -n '1,40p'
  echo
  echo "========== LINK: ${LINK} =========="
  if resolvectl status "${LINK}" >/dev/null 2>&1; then
    resolvectl status "${LINK}" | sed -n '1,120p'
  else
    echo "Interface '${LINK}' not found by resolvectl."
  fi
  echo
  echo "Domains routed (all links):"
  resolvectl domain || true
  echo "============================"
  echo
}

echo "[ BEFORE ]"
print_status

# Ask for sudo once up front
sudo -v

echo "Restarting systemd-resolved ..."
sudo systemctl restart systemd-resolved

echo
echo "[ AFTER ]"
print_status

