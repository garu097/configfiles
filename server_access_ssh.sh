#!/bin/bash

# Kiểm tra nếu không có tham số truyền vào
if [ -z "$1" ]; then
  echo "Usage: $0 <user@server_ip_or_hostname>"
  exit 1
fi

SSH_TARGET=$1

echo "👉 Setting up SSH to $SSH_TARGET"

# 1. Copy public key lên server
echo "📤 Copying SSH public key to $SSH_TARGET..."
ssh-copy-id $SSH_TARGET

# 2. Thêm SSH private key vào ssh-agent
echo "🔐 Adding private key to ssh-agent..."
eval "$(ssh-agent -s)"
ssh-add

# 3. Test SSH connection
echo "🔌 Testing SSH connection..."
ssh $SSH_TARGET

# # 4. Kiểm tra kết nối đến GitLab
# echo "🔍 Testing GitLab SSH access..."
# ssh -T git@gitlab.com
