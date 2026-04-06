if status is-interactive
    # Docker: start if not running (skip inside tmux to avoid delay)
    if not set -q TMUX; and not docker info >/dev/null 2>&1
        echo "⛴️ Initializing Docker..."
        open --background -a Docker
    end

    # Vi mode
    fish_vi_key_bindings
    #set fish_cursor_default block
    #set fish_cursor_insert line
    #set fish_cursor_replace_one underscore
    #set fish_cursor_visual block

    # Overrides de sistema (alias)
    alias vi="nvim"
    alias vim="nvim"
    alias vimdiff="nvim -d"
    alias cat="bat --paging=never"
    alias cd="z"
    alias ls="eza --icons --git"

    # Atalhos (abbr)
    abbr ll "eza -alh"
    abbr lt "eza --tree --level=2 --long --icons --git"
    abbr tree "eza --tree"

    # Git
    abbr gc "git commit -m"
    abbr gca "git commit -a -m"
    abbr gp "git push origin HEAD"
    abbr gpu "git pull origin"
    abbr gst "git status"
    abbr glog "git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
    abbr gdiff "git diff"
    abbr gco "git checkout"
    abbr gb "git branch"
    abbr gba "git branch -a"
    abbr gadd "git add"
    abbr ga "git add -p"
    abbr gcoall "git checkout -- ."
    abbr gr "git remote"
    abbr gre "git reset"

    # Docker
    abbr dco "docker compose"
    abbr dps "docker ps"
    abbr dpa "docker ps -a"
    abbr dx "docker exec -it"
    abbr docker_rm "docker rm -f (docker ps -aq)"

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
set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"

# PATH
set -gx PATH (string match -v "$HOME/.config/tmux/tmuxifier/libexec" $PATH)
set -gx PATH (string match -v "$HOME/.config/tmux/tmuxifier/bin" $PATH)
