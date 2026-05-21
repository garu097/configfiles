#!/bin/bash
n=$(/opt/homebrew/bin/aerospace list-windows --workspace focused | wc -l | tr -d ' ')
ws=$(/opt/homebrew/bin/aerospace list-workspaces --focused)
/opt/homebrew/bin/terminal-notifier -message "Workspace $ws: $n windows" -title AeroSpace
