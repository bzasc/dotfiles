# Neovim

Modular config using [lazy.nvim](https://github.com/folke/lazy.nvim) as plugin manager.

## Install dependencies

### Arch Linux

```shell
sudo pacman -S --needed gcc make ripgrep fd neovim lazygit lua luajit luarocks nodejs npm tree-sitter-cli imagemagick
sudo pacman -S --needed ttf-jetbrains-mono-nerd
```

### macOS

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

## Plugins

### Coding

blink.cmp, nvim-treesitter, LuaSnip, Comment.nvim, nvim-ts-autotag, lazydev.nvim, neorg, sidekick.nvim (Claude AI), rustaceanvim, vim-rails, vim-bundler, vim-rake

### LSP

nvim-lspconfig, mason.nvim, mason-lspconfig.nvim, mason-tool-installer.nvim

Configured servers: `lua_ls`, `gopls`, `zls`, `ts_ls`, `rust-analyzer`, `intelephense`, `bashls`, `ruff`, `pyright`, `ruby-lsp`, `cssls`, `html`, `jsonls`, `yamlls`

### UI

which-key.nvim, noice.nvim, trouble.nvim, tiny-inline-diagnostic.nvim, fidget.nvim, render-markdown.nvim, markdown-preview.nvim, checkmate.nvim, mini.icons

### Editor

mini.nvim (ai, surround, pairs, statusline, icons, files), persistence.nvim, obsidian.nvim, yanky.nvim

### Snacks.nvim

Dashboard, Explorer, Picker, Lazygit, Terminal, Zen Mode, Image, Notifier, Rename

### Formatting

conform.nvim — Go, Lua, TypeScript, JavaScript, JSON, YAML, Markdown, HTML, CSS, Python, PHP, Rust, Shell

### Testing

neotest + adapters: Python, Jest, Vitest, RSpec, Minitest

### Debugging

nvim-dap, nvim-dap-view, nvim-dap-virtual-text, nvim-dap-go, nvim-dap-python, overseer.nvim

### Git

gitsigns.nvim, diffview.nvim

### Theme

sonokai, nvim-colorizer.lua

## Quick Usage

| Command        | Description               |
| -------------- | ------------------------- |
| `:Lazy sync`   | Install/update plugins    |
| `:Mason`       | Manage LSPs and tools     |
| `:checkhealth` | Check installation health |
| `:TSUpdate`    | Update Treesitter parsers |
