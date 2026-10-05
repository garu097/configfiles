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
