# Neovim

## Install dependencies (Arch Linux):

```shell
sudo pacman -S --noconfirm --needed gcc make ripgrep fd neovim
```

## Install dependencies (MacOs):

```shell
# Core requirements
brew install neovim    # v0.11+ required
brew install git
brew install ripgrep   # Fast grep (used by picker)
brew install fd        # Fast find (used by picker)
brew install lazygit   # Git TUI
brew install node      # Required for some LSPs and tools
brew install npm       # Required for markdown-preview

brew install --cask font-jetbrains-mono-nerd-font
# or
brew install --cask font-fira-code-nerd-font

# Image rendering (optional)
brew install imagemagick ghostscript

# Mermaid diagrams (optional)
npm install -g @mermaid-js/mermaid-cli

# LaTeX rendering (optional)
brew install tectonic
```

## Documentation

- Keybinds and plugin defaults: [KEYBINDS.md](KEYBINDS.md)

## Quick Usage

- Install/update plugins: `:Lazy sync`
- Health checks: `:checkhealth`
- Update Treesitter parsers: `:TSUpdate`
