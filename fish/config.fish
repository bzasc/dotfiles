if status is-interactive
    # Starship prompt
    set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
    starship init fish | source

    # Shell integrations
    fzf --fish | source
    zoxide init fish | source
    mise activate fish | source
    uv generate-shell-completion fish | source

    # Docker: start if not running
    if not docker info >/dev/null 2>&1
        echo "⛴️ Initializing Docker..."
        open --background -a Docker
    end

    # Kitty terminfo
    if not infocmp xterm-kitty >/dev/null 2>&1
        echo "xterm-kitty terminfo not found. Installing..."
        set tempfile (mktemp)
        if curl -o "$tempfile" https://raw.githubusercontent.com/kovidgoyal/kitty/master/terminfo/kitty.terminfo
            tic -x -o ~/.terminfo "$tempfile"
        end
        rm "$tempfile"
    end

    # Vi mode
    fish_vi_key_bindings
    #set fish_cursor_default block
    #set fish_cursor_insert line
    #set fish_cursor_replace_one underscore
    #set fish_cursor_visual block

    # Aliases - editors
    alias vi="nvim"
    alias vim="nvim"
    alias vimdiff="nvim -d"

    # Aliases - tools
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
    alias dx="docker exec -it"
    alias docker_rm='docker rm -f (docker ps -aq)'

    # SDKMAN (via fisher plugin ou manual)
    if test -s "$HOME/.sdkman/bin/sdkman-init.sh"
        # Fish não suporta sdkman nativamente — use o plugin fisher/sdkman-for-fish
        # fisher install reitzig/sdkman-for-fish@v2.1.0
    end
end

# Environment variables
set -gx LANG "en_US.UTF-8"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx DOCKER_DEFAULT_PLATFORM "linux/amd64"
set -gx SNACKS_GHOSTTY true
set -gx OBSIDIAN_VAULT "$HOME/annotations/bzasc_brain"
set -gx ZETTELKASTEN "$HOME/annotations/bzasc_brain"
set -gx DAILY_NOTES_TEMPLATE_PATH "$HOME/annotations/bzasc_brain/templates/daily-note.md"
set -gx SDKMAN_DIR "$HOME/.sdkman"

# PATH
fish_add_path "$HOME/.config/tmux/tmuxifier/bin"
