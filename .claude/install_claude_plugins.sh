#!/usr/bin/env bash
# Cài lại các Claude Code plugins trên máy mới (idempotent: chạy lại nhiều lần vô hại).
# enabledPlugins đã nằm trong settings.json (đã track git), nhưng file plugin thực tế
# nằm ở ~/.claude/plugins/ và bị gitignore — nên cần kéo về lại bằng script này.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST="$SCRIPT_DIR/claude-plugins.txt"

echo "🔌 Cài Claude Code plugins"

if ! command -v claude >/dev/null 2>&1; then
    echo "❌ Không tìm thấy 'claude' CLI. Cài Claude Code trước rồi chạy lại script này."
    exit 1
fi

if [ ! -f "$MANIFEST" ]; then
    echo "❌ Không tìm thấy manifest: $MANIFEST"
    exit 1
fi

while IFS= read -r line || [ -n "$line" ]; do
    # Bỏ qua dòng trống hoặc dòng comment
    [[ -z "${line// }" || "$line" =~ ^[[:space:]]*# ]] && continue
    plugin="$(echo "$line" | xargs)"   # trim khoảng trắng

    echo "> Cài: $plugin"
    if claude plugin install "$plugin"; then
        echo "  ✅ $plugin"
    else
        echo "  ⚠️  Bỏ qua (lỗi): $plugin"
    fi
done < "$MANIFEST"

echo "✅ Xong plugins"
