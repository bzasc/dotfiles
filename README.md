# Dotfiles

Configurações pessoais para macOS e Arch Linux.

## Conteúdo

| Diretório    | Descrição                        |
| ------------ | -------------------------------- |
| `brew/`      | Brewfile com pacotes do Homebrew |
| `fastfetch/` | Configuração do Fastfetch        |
| `fish/`      | Shell Fish + plugins             |
| `ghostty/`   | Terminal Ghostty + temas         |
| `hypr/`      | Hyprland (Wayland)               |
| `kitty/`     | Terminal Kitty                   |
| `nvim/`      | Neovim (ver [nvim/README.md](nvim/README.md)) |
| `starship/`  | Prompt Starship                  |
| `tmux/`      | Tmux + scripts e layouts         |
| `wezterm/`   | Terminal WezTerm                 |
| `zsh/`       | Configuração do Zsh              |

## Instalação

```bash
git clone https://github.com/brunoln/dotfiles.git ~/dotfiles
```

### Symlinks

```bash
ln -s ~/dotfiles/fish ~/.config/fish
ln -s ~/dotfiles/fastfetch ~/.config/fastfetch
ln -s ~/dotfiles/ghostty ~/.config/ghostty
ln -s ~/dotfiles/kitty ~/.config/kitty
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/starship ~/.config/starship
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/wezterm ~/.config/wezterm
# Hyprland (Linux only)
ln -s ~/dotfiles/hypr ~/.config/hypr
```

### macOS (Homebrew)

```bash
brew bundle --file=~/dotfiles/brew/Brewfile
```

### Arch Linux

```bash
./install-packages.sh
```
