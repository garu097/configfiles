# ───────────────────────────────────────────────────────────
# Homebrew (sets PATH/MANPATH/INFOPATH for /opt/homebrew)
# ───────────────────────────────────────────────────────────
eval "$(/opt/homebrew/bin/brew shellenv)"
BREW_PREFIX="$(brew --prefix)"

# ───────────────────────────────────────────────────────────
# Oh My Zsh
# ───────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
export STARSHIP_CONFIG="$HOME/.config/starship.toml" #starship
ZSH_DISABLE_COMPFIX=true
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ───────────────────────────────────────────────────────────
# Environment
# ───────────────────────────────────────────────────────────
export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export JAVA_HOME="$BREW_PREFIX/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
export GEM_HOME="$HOME/.gem"
export NVM_DIR="$HOME/.nvm"
export PYENV_ROOT="$HOME/.pyenv"
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='
  --height=40%
  --layout=reverse
  --border
  --preview "bat --style=numbers --color=always {}"
'

# ───────────────────────────────────────────────────────────
# PATH (single export, ordered: user-local → brew opts → SDKs)
# ───────────────────────────────────────────────────────────
path=(
  "$PYENV_ROOT/shims"
  "$PYENV_ROOT/bin"
  "$BREW_PREFIX/opt/openjdk/bin"
  "$ANDROID_HOME/emulator"
  "$ANDROID_HOME/tools"
  "$ANDROID_HOME/tools/bin"
  "$ANDROID_HOME/platform-tools"
  $path
)
typeset -U path PATH   # dedupe

# ───────────────────────────────────────────────────────────
# Lazy-load nvm (save ~200-400ms startup)
# ───────────────────────────────────────────────────────────
NVM_SH="$BREW_PREFIX/opt/nvm/nvm.sh"
if [[ -s "$NVM_SH" ]]; then
  _load_nvm() {
    unset -f nvm node npm npx yarn pnpm corepack 2>/dev/null
    source "$NVM_SH"
  }
  nvm()     { _load_nvm; nvm "$@"; }
  node()    { _load_nvm; node "$@"; }
  npm()     { _load_nvm; npm "$@"; }
  npx()     { _load_nvm; npx "$@"; }
  yarn()    { _load_nvm; yarn "$@"; }
  pnpm()    { _load_nvm; pnpm "$@"; }
  corepack(){ _load_nvm; corepack "$@"; }
fi

# ───────────────────────────────────────────────────────────
# pyenv: shims đã ở trong PATH (python/pip chạy ngay).
# Chỉ defer `pyenv init` (rehash, completion, shell hooks) khi gõ `pyenv`.
# ───────────────────────────────────────────────────────────
if [[ -d "$PYENV_ROOT/bin" ]]; then
  pyenv() {
    unset -f pyenv
    eval "$(pyenv init - zsh)"
    pyenv "$@"
  }
fi

# ───────────────────────────────────────────────────────────
# Plugins & integrations
# ───────────────────────────────────────────────────────────
eval "$(fzf --zsh)" # fzf
eval "$(zoxide init zsh)". # zoxide
eval "$(starship init zsh)" # starship
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ───────────────────────────────────────────────────────────
# Aliases
# ───────────────────────────────────────────────────────────
alias g++='g++ -std=c++20'

if type eza &>/dev/null; then
  alias l="eza --icons=always"
  alias ls="eza --icons=always"
  alias ll="eza -lg --icons=always"
  alias la="eza -lag --icons=always"
  alias lt="eza -lTg --icons=always"
  alias lt2="eza -lTg --level=2 --icons=always"
  alias lt3="eza -lTg --level=3 --icons=always"
  alias lta="eza -lTag --icons=always"
  alias lta2="eza -lTag --level=2 --icons=always"
  alias lta3="eza -lTag --level=3 --icons=always"
fi

# ───────────────────────────────────────────────────────────
# Powerlevel10k user config
# ───────────────────────────────────────────────────────────
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
