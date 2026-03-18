function regen-shell-cache --description 'Regenerate cached shell init scripts in conf.d'
    set -l conf_d ~/.config/fish/conf.d

    echo "Regenerating shell caches..."

    starship init fish --print-full-init >$conf_d/starship.fish
    and echo "  starship OK"

    fzf --fish >$conf_d/fzf.fish
    and echo "  fzf OK"

    zoxide init fish >$conf_d/zoxide.fish
    and echo "  zoxide OK"

    mise activate fish >$conf_d/mise.fish
    and echo "  mise OK"

    uv generate-shell-completion fish >$conf_d/uv.fish
    and echo "  uv OK"

    echo "Done. Restart your shell or run: exec fish"
end
