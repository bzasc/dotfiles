if status is-interactive
    # Docker: start if not running (skip inside tmux to avoid delay)
    if not set -q TMUX; and not docker info >/dev/null 2>&1
        echo "⛴️ Initializing Docker..."
        open --background -a Docker
    end

    # Vi mode
    fish_vi_key_bindings

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
end

# Environment variables
set -gx LANG "en_US.UTF-8"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx DOCKER_DEFAULT_PLATFORM "linux/amd64"
set -gx EDITOR nvim
set -gx SNACKS_GHOSTTY true
set -gx OBSIDIAN_VAULT "$HOME/annotations/bzasc_brain"
set -gx ZETTELKASTEN "$HOME/annotations/bzasc_brain"
set -gx DAILY_NOTES_TEMPLATE_PATH "$HOME/annotations/bzasc_brain/templates/daily-note.md"
set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"

# NOTE on `fish_add_path --path` below: mise's conf.d/mise.fish overwrites $PATH
# wholesale (stale `set -gx PATH` snapshot from `mise activate fish`, regenerated
# by functions/regen-shell-cache.fish) before this file runs, so a plain
# fish_add_path only updates $fish_user_paths — that var only gets folded into
# $PATH at fish's very early startup, which already happened before mise's conf.d
# clobbers it. --path mutates $PATH directly, here, after the clobber, so it
# actually sticks. Without it, tools added here silently vanish from $PATH
# (some, like adb/sdkmanager, happen to still resolve via separate Homebrew shims).

# Android SDK (Homebrew cask)
set -gx ANDROID_HOME /opt/homebrew/share/android-commandlinetools
set -gx ANDROID_SDK_ROOT $ANDROID_HOME
fish_add_path --path $ANDROID_HOME/cmdline-tools/latest/bin
fish_add_path --path $ANDROID_HOME/platform-tools
fish_add_path --path $ANDROID_HOME/emulator

# Go (go install binaries land in GOPATH/bin, default ~/go/bin)
set -gx GOPATH "$HOME/go"
fish_add_path --path $GOPATH/bin
