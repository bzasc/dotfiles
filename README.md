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

## Créditos

- Shaders do cursor do Ghostty (`ghostty/shaders/`) vêm de [sahaj-b/ghostty-cursor-shaders](https://github.com/sahaj-b/ghostty-cursor-shaders).

## Instalação

```bash
git clone https://github.com/bzasc/dotfiles.git ~/dotfiles
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

### Tmux

Este setup usa a função `devsession` do `fish` para criar ou reanexar uma sessão `tmux` com:

```text
code
|- shell
|- shell
`- shell

annotation
```

Use no diretório do projeto:

```bash
devsession           # usa o nome da pasta atual como nome da sessão
devsession workspace    # usa um nome de sessão explícito
```

### macOS (Homebrew)

```bash
brew bundle --file=~/dotfiles/brew/Brewfile
```

### Arch Linux

```bash
./install-packages.sh
```
