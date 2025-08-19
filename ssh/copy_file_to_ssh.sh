#!/bin/bash
# Dùng: ./copy_any.sh <SOURCE> <TARGET> [PORT]
# Hỗ trợ: copy local->remote và remote->local (scp -r)
# PORT mặc định = 22 nếu không nhập

set -euo pipefail

if [ $# -lt 2 ] || [ $# -gt 3 ]; then
  echo "Cách dùng: $0 <SOURCE> <TARGET> [PORT]"
  echo "Ví dụ local -> remote (port mặc định 22): $0 ./test.txt user@192.168.1.100:/home/user/"
  echo "Ví dụ remote -> local với port custom:   $0 user@192.168.1.100:/home/user/test.txt ./ 2222"
  exit 1
fi

SOURCE=$1
TARGET=$2
PORT=${3:-22}   # Nếu không truyền thì dùng 22

# Kiểm tra port là số
if ! [[ "$PORT" =~ ^[0-9]+$ ]]; then
  echo "❌ PORT phải là số. Giá trị hiện tại: '$PORT'"
  exit 1
fi

# Ít nhất một trong hai tham số phải là remote (chứa dấu :)
if ! [[ "$SOURCE" == *:* || "$TARGET" == *:* ]]; then
  echo "❌ Cần có ít nhất một tham số dạng remote: user@host:/path"
  exit 1
fi

echo "=== SCP ==="
echo "Source : $SOURCE"
echo "Target : $TARGET"
echo "Port   : $PORT"
echo "================="

scp -r -p -C -P "$PORT" "$SOURCE" "$TARGET"

echo "✅ Hoàn tất."