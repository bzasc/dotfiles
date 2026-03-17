#!/bin/bash

dist=$(hostnamectl | grep "Operating System")

if [[ $dist =~ "Arch Linux" ]]; then
  echo "  # Arch Linux detected. Using pacman"

  echo "  # Installing shell & prompt"
  sudo pacman -S --needed fish starship

  echo "  # Installing CLI & dev tools"
  sudo pacman -S --needed base-devel bat eza fd fzf gcc git github-cli htop jq lazygit lua luajit lua51 luarocks make cmake man-db neovim ripgrep tree tree-sitter-cli wget wl-clipboard openssh zoxide

  echo "  # Installing language toolchains"
  sudo pacman -S --needed go gopls golang-ci-lint nodejs npm python rustup ruby rbenv

  echo "  # Installing common apps"
  sudo pacman -S --needed firefox gparted btrfs-progs ntfs-3g libreoffice-still power-profiles-daemon thunderbird vlc docker docker-compose

  echo "  # Installing fonts"
  sudo pacman -S --needed ttf-hack-nerd ttf-jetbrains-mono-nerd

  echo "  # Installing uv (Python)"
  curl -LsSf https://astral.sh/uv/install.sh | sh

  echo "  # Installing mise (runtime manager)"
  curl https://mise.run | sh

  echo "  # Installing Rust nightly"
  rustup toolchain install nightly

  echo "  # Setting fish as default shell"
  chsh -s /usr/bin/fish

  echo "  # Installing fisher (fish plugin manager)"
  fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

  echo "  # Done! Log out and back in for fish to take effect."
fi
