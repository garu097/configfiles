#!/usr/bin/env bash
set -euo pipefail

# Usage: ./check_ssh_key.sh user@host [--key-path ~/.ssh/custom.pub] [--fix-duplicates]
ssh_target="${1:-}"
[[ -z "${ssh_target}" ]] && { echo "Usage: $0 <user@host> [--key-path <pub_key_path>] [--fix-duplicates]"; exit 1; }

key_path_override=""
fix_duplicates="false"

shift || true
while [[ $# -gt 0 ]]; do
  case "$1" in
    --key-path)
      key_path_override="$2"; shift 2;;
    --fix-duplicates)
      fix_duplicates="true"; shift;;
    *)
      echo "Unknown arg: $1"; exit 1;;
  esac
done

echo "👉 Kiểm tra SSH key cho: ${ssh_target}"

resolve_pub_key() {
  local host="$1"

  # Nếu user chỉ định sẵn key
  if [[ -n "${key_path_override}" ]]; then
    if [[ -f "${key_path_override}" ]]; then
      echo "${key_path_override}"
      return
    else
      echo "❌ Không tìm thấy file: ${key_path_override}" >&2
      exit 1
    fi
  fi

  # Thử đọc danh sách identity từ ssh config
  mapfile -t ids < <(ssh -G "${host}" 2>/dev/null | awk '/^identityfile /{print $2}')
  for id in "${ids[@]:-}"; do
    [[ -f "${id}.pub" ]] && { echo "${id}.pub"; return; }
  done

  # Fallback phổ biến
  for cand in "$HOME/.ssh/id_ed25519.pub" "$HOME/.ssh/id_rsa.pub"; do
    [[ -f "$cand" ]] && { echo "$cand"; return; }
  done

  echo "❌ Không tìm thấy public key. Hãy tạo bằng: ssh-keygen -t ed25519" >&2
  exit 1
}

pub_key_path="$(resolve_pub_key "${ssh_target}")"
echo "🔑 Public key: ${pub_key_path}"

if ! command -v ssh-keygen >/dev/null 2>&1; then
  echo "⚠️  ssh-keygen không có trong PATH, bỏ qua hiển thị fingerprint."
else
  echo -n "📎 Fingerprint: "
  ssh-keygen -lf "${pub_key_path}" || true
fi

pub_key_content="$(cat "${pub_key_path}")"
pub_key_comment="$(awk '{print $NF}' "${pub_key_path}")"

echo "📤 Kiểm tra trên remote (~/.ssh/authorized_keys)..."
remote_auth_keys="$(ssh -o BatchMode=yes -o ConnectTimeout=5 "${ssh_target}" 'cat ~/.ssh/authorized_keys 2>/dev/null || true')"

if [[ -z "${remote_auth_keys}" ]]; then
  echo "ℹ️  Remote không có ~/.ssh/authorized_keys hoặc trống."
  echo "   → Key *chưa* được add, hoặc file chưa tồn tại."
  exit 0
fi

# Đếm số lần xuất hiện chính xác của key (so khớp toàn bộ dòng)
occurrences="$(printf "%s\n" "${remote_auth_keys}" | grep -Fx -- "${pub_key_content}" | wc -l | awk '{print $1}')"

if [[ "${occurrences}" -eq 0 ]]; then
  echo "❌ Key hiện tại *chưa có* trong authorized_keys của ${ssh_target}."
  echo "   Gợi ý: ssh-copy-id -i \"${pub_key_path}\" ${ssh_target}"
  exit 0
fi

echo "✅ Key đã có trong authorized_keys. Số lần xuất hiện: ${occurrences}"

# Kiểm tra trùng lặp và (tùy chọn) sửa
if [[ "${occurrences}" -gt 1 ]]; then
  echo "⚠️  Phát hiện trùng lặp key (${occurrences} bản)."
  if [[ "${fix_duplicates}" == "true" ]]; then
    echo "🧹 Loại bỏ dòng trùng lặp (giữ nguyên thứ tự dòng đầu tiên)..."
    ssh "${ssh_target}" 'set -e; f="$HOME/.ssh/authorized_keys"; cp "$f" "$f.bak"; awk "!seen[\$0]++" "$f" > "$f.tmp" && mv "$f.tmp" "$f"'
    echo "✔️  Đã làm sạch duplicates. Sao lưu: ~/.ssh/authorized_keys.bak"
  else
    echo "   (Bạn có thể chạy lại với --fix-duplicates để tự động dọn duplicate)"
  fi
else
  echo "🟢 Không có bản trùng lặp."
fi

# Kiểm tra quyền thư mục và file
echo "🔍 Kiểm tra quyền remote ~/.ssh và authorized_keys:"
ssh "${ssh_target}" 'set -e; 
  test -d "$HOME/.ssh" && stat -c "%a %n" "$HOME/.ssh" || echo "N/A ~/.ssh";
  test -f "$HOME/.ssh/authorized_keys" && stat -c "%a %n" "$HOME/.ssh/authorized_keys" || echo "N/A authorized_keys";
' || true

echo "📌 Quyền khuyến nghị: ~/.ssh -> 700, authorized_keys -> 600"
echo "🎉 Hoàn tất kiểm tra."