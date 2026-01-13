# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.config/zsh/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git docker docker-compose)

source $ZSH/oh-my-zsh.sh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if ! docker info >/dev/null 2>&1; then
    echo "⛴️ Initializing Docker..."
    open --background -a Docker
fi

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"

export STARSHIP_CONFIG="~/.config/starship/starship.toml"
export LANG="en_US.UTF-8"

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

alias vi="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"

alias cat="bat --paging=never"
alias cd="z"
alias ls="eza --icons --git"
alias ll="eza -alh"
alias lt="eza --tree --level=2 --long --icons --git"
alias tree="eza --tree"

# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'

# Docker
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"
alias docker_rm='docker rm -f $(docker ps -aq)'

bindkey -v

# Obsidian (caminho do vault)
export OBSIDIAN_VAULT="$HOME/annotations/bzasc_brain"
export ZETTELKASTEN="$HOME/annotations/bzasc_brain"
export DAILY_NOTES_TEMPLATE_PATH="$HOME/annotations/bzasc_brain/templates/daily-note.md"

# Vi mode
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
export VI_MODE_SET_CURSOR=true
export KEYTIMEOUT=1

export XDG_CONFIG_HOME="/Users/bzasc/.config"
export DOCKER_DEFAULT_PLATFORM=linux/amd64
export PATH="$HOME/.config/tmux/tmuxifier/bin:$PATH"

eval "$(tmuxifier init -)"
eval "$(uv generate-shell-completion zsh)"

# Java
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
