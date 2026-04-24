ln -sf "$(pwd)/zsh/config/.zshrc" ~/.zshrc
ln -sf "$(pwd)/zsh/powerlevel10k/.p10k.zsh" ~/.p10k.zsh
ln -sf "$(pwd)/wezterm/.wezterm.lua" ~/.wezterm.lua
ln -sf "$(pwd)/tmux/tmux.conf" ~/.tmux.conf
ln -sf "$(pwd)/.opencode" ~/.opencode

chmod +x ./ssh/server_access_ssh.sh           # đảm bảo có quyền thực thi
ln -s "$(pwd)/ssh/server_access_ssh.sh" ~/server_access_ssh.sh
