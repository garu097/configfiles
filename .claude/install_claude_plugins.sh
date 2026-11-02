#!/usr/bin/env bash
# Cài lại các Claude Code plugins + skills bên ngoài trên máy mới (idempotent: chạy lại nhiều lần vô hại).
# enabledPlugins đã nằm trong settings.json (đã track git), nhưng file plugin thực tế
# nằm ở ~/.claude/plugins/ và bị gitignore — nên cần kéo về lại bằng script này.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST="$SCRIPT_DIR/claude-plugins.txt"

echo "🔌 Cài Claude Code plugins"

for cmd in claude jq; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "❌ Không tìm thấy '$cmd'. Cài trước rồi chạy lại script này."
        exit 1
    fi
done

if [ ! -f "$MANIFEST" ]; then
    echo "❌ Không tìm thấy manifest: $MANIFEST"
    exit 1
fi

# Trạng thái hiện tại, dùng để chọn install/add (chưa có) hay update (đã có)
INSTALLED_PLUGINS="$(claude plugin list --json < /dev/null 2>/dev/null || echo '[]')"
KNOWN_MARKETPLACES="$(claude plugin marketplace list --json < /dev/null 2>/dev/null || echo '[]')"

while IFS= read -r line || [ -n "$line" ]; do
    # Bỏ qua dòng trống hoặc dòng comment
    [[ -z "${line// }" || "$line" =~ ^[[:space:]]*# ]] && continue
    plugin="$(echo "$line" | xargs)"   # trim khoảng trắng

    # < /dev/null: không để claude đọc mất stdin (manifest) của vòng lặp
    if [[ "$plugin" == marketplace\ * ]]; then
        source="${plugin#marketplace }"
        name="$(jq -r --arg s "$source" '.[] | select(.repo == $s or .url == $s) | .name' <<< "$KNOWN_MARKETPLACES")"
        if [ -n "$name" ]; then
            echo "> Update marketplace: $name"
            cmd=(claude plugin marketplace update "$name")
        else
            echo "> Thêm marketplace: $source"
            cmd=(claude plugin marketplace add "$source")
        fi
        if "${cmd[@]}" < /dev/null; then
            echo "  ✅ $source"
        else
            echo "  ⚠️  Bỏ qua (lỗi): $source"
        fi
        continue
    fi

    if jq -e --arg id "$plugin" 'any(.[]; .id == $id)' <<< "$INSTALLED_PLUGINS" >/dev/null; then
        echo "> Update: $plugin"
        cmd=(claude plugin update "$plugin" --scope user)
    else
        echo "> Cài: $plugin"
        cmd=(claude plugin install "$plugin")
    fi
    if "${cmd[@]}" < /dev/null; then
        echo "  ✅ $plugin"
    else
        echo "  ⚠️  Bỏ qua (lỗi): $plugin"
    fi
done < "$MANIFEST"

echo "✅ Xong plugins"

# Skill bên ngoài (Skills CLI)
SKILLS_MANIFEST="$SCRIPT_DIR/claude-skills.txt"
[ -f "$SKILLS_MANIFEST" ] || exit 0

echo "🧩 Cài Claude Code skills"

if ! command -v npx >/dev/null 2>&1; then
    export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
    # shellcheck disable=SC1091
    . "$(brew --prefix nvm)/nvm.sh" 2>/dev/null || . "$NVM_DIR/nvm.sh" 2>/dev/null || true
    nvm use default >/dev/null 2>&1 || nvm install --lts >/dev/null
fi

if ! command -v npx >/dev/null 2>&1; then
    echo "❌ Không tìm thấy 'npx'. Cài Node (qua nvm) trước rồi chạy lại script này."
    exit 1
fi

while IFS= read -r line || [ -n "$line" ]; do
    [[ -z "${line// }" || "$line" =~ ^[[:space:]]*# ]] && continue
    read -r repo skill <<< "$line"

    # Skills CLI ghi skill global đã cài vào ~/.agents/.skill-lock.json
    if [ -d "$HOME/.claude/skills/$skill" ] &&
        jq -e --arg s "$skill" '.skills[$s]' "$HOME/.agents/.skill-lock.json" >/dev/null 2>&1; then
        echo "> Update: $skill ($repo)"
        cmd=(npx -y skills update "$skill" -g -y)
    else
        echo "> Cài: $skill ($repo)"
        cmd=(npx -y skills add "$repo" --skill "$skill" -g -a claude-code -y)
    fi
    if "${cmd[@]}" < /dev/null; then
        echo "  ✅ $skill"
    else
        echo "  ⚠️  Bỏ qua (lỗi): $skill"
    fi
done < "$SKILLS_MANIFEST"

echo "✅ Xong skills"
