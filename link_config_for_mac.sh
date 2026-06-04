# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file=./brew/Brewfile

# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# tmux theme
LIB_FILE="$(pwd)/tmux/lib.txt"
echo "🚀 Checking lib theme for tmux"
if [ ! -f "$LIB_FILE" ]; then
    echo "❌ Error: not found $LIB_FILE!"
    exit 1
fi

while IFS= read -r line || [ -n "$line" ]; do
    # Bỏ qua các dòng trống hoặc dòng bắt đầu bằng dấu #
    [[ -z "$line" || "$line" =~ ^# ]] && continue
    
    # Thực thi lệnh git clone từ file lib.txt 
    echo "> Chạy: $line"
    eval "$line"
done < "$LIB_FILE"

# Link file 
echo "🚀 Linking configuration files"
ln -sf "$(pwd)/zsh/config/.zshrc" ~/.zshrc
ln -sf "$(pwd)/zsh/starship/starship.toml" ~/.config/starship.toml
# ln -sf "$(pwd)/zsh/powerlevel10k/.p10k.zsh" ~/.p10k.zsh

ln -sf "$(pwd)/aespace" ~/.config/aerospace
ln -sf "$(pwd)/wezterm/wezterm.lua" ~/.wezterm.lua
ln -sf "$(pwd)/tmux/tmux.conf" ~/.tmux.conf
ln -sf "$(pwd)/.opencode" ~/.opencode

# Link Claude Code config (per-item, keep runtime data in ~/.claude)
mkdir -p ~/.claude
for item in "$(pwd)"/.claude/*; do
    [ -e "$item" ] || continue
    name=$(basename "$item")
    [ "$name" = ".gitignore" ] && continue
    [ "$name" = "settings.local.json" ] && continue
    ln -sf "$item" "$HOME/.claude/$name"
done

source ~/.zshrc

chmod +x ./ssh/server_access_ssh.sh           # đảm bảo có quyền thực thi
ln -s "$(pwd)/ssh/server_access_ssh.sh" ~/server_access_ssh.sh
