mkdir -p ~/.config/tmux/scripts

cat > ~/.config/tmux/scripts/memory.sh <<'EOF'
#!/usr/bin/env bash

case "$(uname)" in
  Darwin)
    memory_pressure | awk '/System-wide/ {print $(NF)}'
    ;;
  Linux)
    free | awk '/Mem:/ {printf "%.0f", $3/$2*100}'
    ;;
  *)
    echo "N/A"
    ;;
esac
EOF
w
chmod +x ~/.config/tmux/scripts/memory.sh