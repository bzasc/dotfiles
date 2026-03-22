# Dotfiles

Minhas configurações pessoais.

## Conteúdo

| Diretório    | Descrição                                     |
| ------------ | --------------------------------------------- |
| `brew/`      | Brewfile com pacotes do Homebrew              |
| `fastfetch/` | Configuração do Fastfetch                     |
| `fish/`      | Shell Fish + plugins                          |
| `ghostty/`   | Terminal Ghostty + temas                      |
| `hypr/`      | Hyprland (Wayland)                            |
| `kitty/`     | Terminal Kitty                                |
| `nvim/`      | Neovim (ver [nvim/README.md](nvim/README.md)) |
| `starship/`  | Prompt Starship                               |
| `tmux/`      | Tmux + scripts e layouts                      |
| `wezterm/`   | Terminal WezTerm                              |
| `zsh/`       | Configuração do Zsh                           |

## Instalação

```bash
git clone https://github.com/brunoln/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### Dependências

```bash
uv tool install dotbot
```

### Symlinks (dotbot)

```bash
./install.sh           # cria os symlinks via dotbot
./install.sh --backup  # faz backup de ~/.config antes de linkar
```

Com `--backup`, diretórios existentes (não-symlinks) são movidos para `~/.config-backup/<timestamp>/`.

### Tmuxifier

O [tmuxifier](https://github.com/jimeh/tmuxifier) não é versionado neste repositório. Após rodar o `install.sh`, clone manualmente:

```bash
git clone https://github.com/jimeh/tmuxifier.git ~/.config/tmux/tmuxifier
```

### macOS (Homebrew)

```bash
brew bundle --file=~/dotfiles/brew/Brewfile
```

### Arch Linux

```bash
./install-packages.sh
```
