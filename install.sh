#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.config-backup/$(date +%Y%m%d_%H%M%S)"

configs=(fish ghostty kitty wezterm nvim tmux fastfetch starship)

needs_backup=false
while [[ $# -gt 0 ]]; do
  case $1 in
    --backup) needs_backup=true; shift ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

if $needs_backup; then
  echo "Backing up existing configs to $BACKUP_DIR"
  mkdir -p "$BACKUP_DIR"

  for dir in "${configs[@]}"; do
    target="$HOME/.config/$dir"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
      echo "  $target -> $BACKUP_DIR/$dir"
      mv "$target" "$BACKUP_DIR/$dir"
    fi
  done

  echo ""
fi

echo "Running dotbot..."
dotbot -d "$DOTFILES_DIR" -c "$DOTFILES_DIR/install.conf.yaml"
