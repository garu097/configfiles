#!/usr/bin/env bash
# Total CPU usage across all cores, as a percentage.

case "$(uname)" in
  Darwin) cores=$(sysctl -n hw.ncpu) ;;
  Linux)  cores=$(nproc) ;;
  *)      echo "N/A"; exit 0 ;;
esac

ps -A -o %cpu | awk -v c="$cores" '{s+=$1} END {printf "%.0f%%", s/c}'
