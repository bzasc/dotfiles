#!/bin/bash

dist=$(hostnamectl|grep "Operating System")

if [[ $dist =~ "Arch Linux" ]]; then
    echo "  # Arch Linux detected. Using pacman"
    echo "  # Installing cli & dev tools"
    sudo pacman -S --needed\
        base-devel\
        bat\
        fd\
        fzf\
        gcc\
        git\
        github-cli\
        kitty\
        rustup\
        lua luajit lua51 luarocks\
        make cmake\
        man-db\
        postgresql\
        rbenv ruby-build\
        ripgrep\
        ttf-hack-nerd\
        wget\
        wl-clipboard

    echo "  # Installing common apps"
    sudo pacman -S --needed\
        firefox\
        gparted btrfs-progs ntfs-3g\
        libreoffice-still\
        neovim\
        power-profiles-daemon\
        thunderbird\
        vlc

    echo "  # Installing uv"
    curl -LsSf https://astral.sh/uv/install.sh | sh
    
    echo "  # Installing rust nightly"
    rustup toolchain install nightly
    cargo +nightly build

fi
