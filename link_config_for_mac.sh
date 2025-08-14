ln -s ./zsh/config/.zshrc ~/.zshrc
ln -s ./zsh/powerlevel10k/.p10k.zsh ~/.p10k.zsh
ln -s ./wezterm/.wezterm.lua ~/.wezterm.lua
ln -s ./tmux/tmux.conf ~/.tmux.conf

chmod +x ./ssh/server_access_ssh.sh           # đảm bảo có quyền thực thi
ln -s "$(pwd)/ssh/server_access_ssh.sh" ~/server_access_ssh.sh
