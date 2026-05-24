# nvim

Config pessoal Neovim 0.12+. Usa gerenciador nativo `vim.pack` (sem lazy.nvim).

## Créditos

Base derivada de [tduyng](https://gitlab.com/tduyng). Modificada para uso pessoal.

## Requisitos

- Neovim >= 0.12 (precisa de `vim.pack`)
- `git`, `ripgrep`, `fd`
- `stylua` (formatação Lua)
- `just` (opcional, para tasks)

## Estrutura

```
nvim/
├── init.lua              # entrypoint: leader + require("config") + require("plugins")
├── justfile              # tasks: check, fmt, validate, clean
├── stylua.toml
├── nvim-pack-lock.json   # lock do vim.pack
├── lsp/                  # configs LSP nativos (vim.lsp.config)
│   ├── lua_ls.lua, ruby_lsp.lua, vtsls.lua, rust_analyzer.lua, ...
├── lua/
│   ├── config/           # opções core
│   │   ├── theme.lua         # Catppuccin com paletas customizadas (gruvbox-like, sonokai)
│   │   ├── options.lua
│   │   ├── keymaps.lua
│   │   ├── session.lua
│   │   ├── statusline.lua
│   │   ├── tabline.lua
│   │   ├── diagnostics.lua
│   │   ├── autocmds.lua
│   │   ├── lsp.lua
│   │   ├── packui.lua        # UI custom para vim.pack
│   │   └── ui2.lua
│   └── plugins/          # cada arquivo = vim.pack.add(...)
│       ├── blink.lua, conform.lua, dap.lua, git.lua,
│       ├── grug-far.lua, markdown.lua, obsidian.lua,
│       ├── sidekick.lua, snacks.lua, treesitter.lua,
│       ├── whichkey.lua, yanky.lua, ...
├── snippets/             # snippets JSON
└── spell/                # dicionários
```

## Instalação

```sh
git clone <repo> ~/.config/nvim
nvim   # vim.pack baixa plugins no primeiro start
```

Leader = `<Space>`.

## Tasks (justfile)

```sh
just check        # valida config headless
just fmt          # stylua .
just fmt-check    # stylua --check
just validate     # check + fmt-check
just clean        # apaga data/state/cache do nvim (config intacto)
```

## Gerenciamento de plugins

Plugins via `vim.pack.add({...})` em `lua/plugins/*.lua`. Para adicionar:

1. Criar `lua/plugins/<nome>.lua` com `vim.pack.add({ "https://github.com/owner/repo" })`
2. Adicionar `require("plugins.<nome>")` em `lua/plugins/init.lua`
3. Reiniciar nvim

UI custom de gerenciamento: `lua/config/packui.lua`.

## LSP

Configs em `lsp/<server>.lua` usando `vim.lsp.config` nativo. Carregamento em `lua/config/lsp.lua`.
