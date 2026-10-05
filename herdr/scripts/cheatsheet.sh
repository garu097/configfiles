#!/usr/bin/env bash
# Render the [keys] section of herdr's config.toml as a readable cheatsheet.
# Bound to a popup so the bindings are always one keystroke away.

CONFIG="${HERDR_CONFIG:-$HOME/.config/herdr/config.toml}"

[ -f "$CONFIG" ] || { echo "config not found: $CONFIG"; read -r; exit 1; }

awk '
  # Track which top-level table we are in.
  /^\[keys\]/            { in_keys = 1; next }
  /^\[\[keys\.command\]\]/ { in_keys = 1; in_cmd = 1; key = ""; cmd = ""; next }
  /^\[/                  { in_keys = 0; in_cmd = 0; next }
  !in_keys               { next }

  # Section banners: # --- title ---
  /^#[[:space:]]*---/ {
    title = $0
    sub(/^#[[:space:]]*-+[[:space:]]*/, "", title)
    sub(/[[:space:]]*-+[[:space:]]*$/, "", title)
    if (title != "") printf "\n  \033[1;35m%s\033[0m\n", toupper(title)
    next
  }

  # name = "value"   # optional trailing comment
  /^[a-z_]+[[:space:]]*=[[:space:]]*"/ {
    line = $0
    name = line; sub(/[[:space:]]*=.*/, "", name)

    val = line
    sub(/^[^"]*"/, "", val)
    sub(/".*/, "", val)
    gsub(/\\\\/, "\\", val)   # un-escape TOML backslashes
    if (val == "") next

    note = ""
    if (match(line, /#[^"]*$/)) {
      note = substr(line, RSTART + 1)
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", note)
    }

    if (in_cmd) {
      if (name == "key")     { key = val }
      if (name == "command") { cmd = val }
      if (key != "" && cmd != "") {
        printf "  \033[1;36m%-22s\033[0m %-26s \033[2m%s\033[0m\n", key, "popup", cmd
        key = ""; cmd = ""
      }
      next
    }

    gsub(/_/, " ", name)
    printf "  \033[1;36m%-22s\033[0m %-26s \033[2m%s\033[0m\n", val, name, note
  }
' "$CONFIG"

printf "\n  \033[2mconfig: %s\033[0m\n" "$CONFIG"
printf "\n  \033[1mEnter\033[0m to close "
read -r
