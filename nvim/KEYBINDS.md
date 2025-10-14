# Keybinds and Plugin Usage

This document lists:
- Global keymaps from `lua/keymaps.lua` and other configured points.
- Keymaps introduced by active plugins in `lua/lazy-plugins.lua`.
- Common user commands provided by those plugins (where applicable).

Leader key: space (`<leader> = " "`).

## Active Plugins (by module)
- LSP: `neovim/nvim-lspconfig` (+ `mason*`, `fidget.nvim`, `saghen/blink.cmp`, `folke/lazydev.nvim`)
- Formatting: `stevearc/conform.nvim`
- Completion: `saghen/blink.cmp` (+ `L3MON4D3/LuaSnip`)
- UI/Status: `nvim-lualine/lualine.nvim`, `folke/noice.nvim`, `rcarriga/nvim-notify`
- Treesitter: `nvim-treesitter/nvim-treesitter`, `nvim-treesitter/nvim-treesitter-context`, `windwp/nvim-ts-autotag`
- Fuzzy finder: `ibhagwan/fzf-lua`
- Debug: `mfussenegger/nvim-dap`, `rcarriga/nvim-dap-ui`, `mfussenegger/nvim-dap-python`
- Movement/Text (mini.nvim): `mini.ai`, `mini.clue`, `mini.files`, `mini.splitjoin`, `mini.move`, `mini.bufremove`, `mini.comment`, `mini.surround`, `mini.icons`
- Aesthetics: `lukas-reineke/indent-blankline.nvim`, `nvim-tree/nvim-web-devicons`, `sainnhe/sonokai`
- Obsidian: `epwalsh/obsidian.nvim`
- Ruby: `tpope/vim-rails`, `tpope/vim-bundler`, `tpope/vim-rake`
- Python venv: `linux-cultist/venv-selector.nvim`
- Markdown: `iamcco/markdown-preview.nvim`, `bngarren/checkmate.nvim`
- Utilities: `nvim-lua/plenary.nvim`, `christoomey/vim-tmux-navigator`, `preservim/vimux`, `nvim-lightbulb`
- Disabled: `nvim-telescope/telescope.nvim` (enabled = false)

## Global Keymaps
- `i jk` → `<Esc>` (quickly leave insert)
- `n <leader>nh` → `:nohl<CR>` (clear search highlights)
- `n x` → `"_x` (delete without yanking)
- `n n` → `nzzzv` and `n N` → `Nzzzv` (center after search navigation)
- `c <CR>` → adds `zzzv` after `/` searches to center results
- `n <leader>+` → `<C-a>` (increment number)
- `n <leader>-` → `<C-x>` (decrement number)
- Splits:
  - `n <leader>sv` → vertical split
  - `n <leader>sh` → horizontal split
  - `n <leader>se` → equalize splits
  - `n <leader>sx` → close current split
- Tabs:
  - `n <leader>to` → new tab
  - `n <leader>tx` → close tab
  - `n <leader>tn` → next tab
  - `n <leader>tp` → previous tab
  - `n <leader>tf` → open current buffer in new tab
- Noice:
  - `n <leader>nd` → `:NoiceDismiss<CR>`
- Wrap:
  - `n <leader>tw` → toggle line wrap
- Obsidian (custom templates/search in vault):
  - `n <leader>on` → `:ObsidianTemplate note` (then clean initial blank lines)
  - `n <leader>oc` → `:ObsidianTemplate class-note` (then clean initial blank lines)
  - `n <leader>os` → `FzfLua files` in vault (`/home/bzasc/annotations/bzasc_brain`)
  - `n <leader>oz` → `FzfLua live_grep` in vault

## LSP (on_attach)
Defined in `plugins/lspconfig.lua` when a client attaches:
- `n gr` → LSP References (`fzf-lua.lsp_references`)
- `n gI` → LSP Implementations (`fzf-lua.lsp_implementations`)
- `n gd` → LSP Definitions (`fzf-lua.lsp_definitions`)
- `n gD` → LSP Declaration (`vim.lsp.buf.declaration`)
- `n gO` → Document Symbols (`fzf-lua.lsp_document_symbols`)
- `n gW` → Workspace Symbols (dynamic) (`fzf-lua.lsp_dynamic_workspace_symbols`)
- `n <leader>th` → Toggle Inlay Hints (if supported)
- `n gy` → Type Definitions (`fzf-lua.lsp_type_definitions`)
- `n gA` / `x gA` → Code Actions (FZF picker)
- `n <leader>gi` → Incoming Calls (FZF)
- `n <leader>go` → Outgoing Calls (FZF)

Common commands:
- LSP core: `:LspInfo`, `:LspStart`, `:LspStop`, `:LspRestart`, `:LspLog`
- Mason UI: `:Mason`
- Mason Tool Installer: `:MasonToolsInstall`, `:MasonToolsUpdate`, `:MasonToolsClean`

Additional LSP keymaps:
- `n K` → Hover documentation
- `n [d` / `n ]d` → Previous/next diagnostic
- `n gl` → Show line diagnostics
- `n <leader>rn` and `n grn` → Rename symbol
- `n ga` / `x ga` → Code action (builtin)

## Plugins — Keymaps and Commands

### fzf-lua
Keymaps:
- `n/x <leader>fb` → Search in current buffer (normal: ripgrep; visual: `blines`)
- `n <leader>fB` → Buffers
- `n <leader>fc` → Highlights
- `n <leader>fd` → Document diagnostics
- `n <leader>ff` → Files
- `n <leader>fg` → Live grep
- `x <leader>fg` → Grep visual selection
- `n <leader>fh` → Help tags
- `n <leader>fr` → Recent files
- `n <leader>f<` → Resume last fzf command
- `n z=` → Spelling suggestions

Picker controls (inside fzf windows):
- Builtin: `<C-/>` help, `<C-a>` fullscreen, `<C-i>` toggle preview
- FZF: `alt-s` toggle, `alt-a` toggle-all, `ctrl-i` toggle preview

Commands:
- `:FzfLua <picker>` — run any picker, e.g. `files`, `live_grep`, `buffers`, `oldfiles`, `help_tags`, `resume`, `lsp_*`.

### mini.files (file explorer)
Keymaps:
- `n <leader>e` → open explorer at current buffer path
- In mini.files buffers:
  - `?` help
  - `<CR>` open/enter (`go_in_plus`)
  - `<Tab>` go out/up (`go_out_plus`)
  - `<C-w>s` split below and open file; `<C-w>v` split right and open file

### mini.splitjoin
Keymaps:
- `n <leader>cj` → toggle join/split of code block

### mini.bufremove
Keymaps:
- `n <leader>bd` → delete current buffer preserving window layout

### mini.surround
Keymaps (custom mappings):
- `n/v <leader>sa` add
- `n <leader>sd` delete
- `n <leader>sf` find to the right
- `n <leader>sF` find to the left
- `n <leader>sH` highlight
- `n <leader>sr` replace
- `n <leader>sn` update n_lines
- `n <leader>sl` suffix last
- `n <leader>sN` suffix next

### mini.ai
Text objects:
- `a/i f` → function (Treesitter)
- `a/i g` → whole buffer

### mini.move
Keymaps (defaults):
- Normal: `<M-h>` left, `<M-j>` move line down, `<M-k>` move line up, `<M-l>` right
- Visual: `<M-h>`, `<M-j>`, `<M-k>`, `<M-l>` move selection left/down/up/right

### mini.comment
Keymaps (defaults):
- Normal: `gc{motion}` toggle linewise, `gcc` toggle current line
- Normal: `gb{motion}` toggle blockwise
- Visual: `gc` toggle selection linewise, `gb` toggle selection blockwise

### mini.icons
Keymaps:
- None (no default mappings)

### mini.clue
- Shows hints for key sequences; does not create mappings.
- Triggers: `g`, `` ` ``, `"`, `<C-r>` (normal/visual/insert/cmd), `<C-w>`, `i <C-x>`, `z`, `<leader>` (n/visual), `[` and `]`.
- Displays groups: `+ai`, `+buffers`, `+code`, `+debug`, `+find`, `+lsp`, `+obsidian`, `+tabs`, `+loclist/quickfix`, `+prev/+next`.

### flash.nvim
Keymaps:
- `n/x/o s` → jump
- `o r` → Treesitter search
- `o R` → remote jump

### DAP / DAP UI / DAP Python
Keymaps:
- `n <leader>dc` → start/continue debugging
- `n <leader>db` → toggle breakpoint
- `n <leader>dt` → terminate debugging
- `n <leader>du` → toggle DAP UI

Commands:
- nvim-dap: `:DapContinue`, `:DapToggleBreakpoint`, `:DapTerminate`, `:DapStepOver`, `:DapStepInto`, `:DapStepOut`
- nvim-dap-ui: `:DapUiOpen`, `:DapUiClose`, `:DapUiToggle`

### Treesitter & Context
Keymaps:
- Incremental selection: `<CR>` to init/increase, `<BS>` to decrease (scope incremental disabled)
- Context jump: `n [c` (expr) → in diff: previous change; otherwise: jump to upper context

Commands:
- Treesitter core: `:TSUpdate`, `:TSInstall`, `:TSUninstall`, `:TSBufEnable`, `:TSBufDisable`
- Treesitter Context: `:TSContextEnable`, `:TSContextDisable`, `:TSContextToggle`, `:TSContextGoToContext`

### Obsidian
Keymaps:
- `n <leader>oq` Quick Switch
- `n <leader>og` Search
- `n <leader>ot` Today
- `n <leader>oy` Yesterday
- `n <leader>on` New Note
- `n <leader>ol` Follow Link
- `n <leader>oL` Link New
- In vault buffers: `gf` → pass-through for markdown/wiki links

Commands:
- `:ObsidianQuickSwitch`, `:ObsidianSearch`, `:ObsidianToday`, `:ObsidianYesterday`, `:ObsidianNew`, `:ObsidianLink`, `:ObsidianLinkNew`, `:ObsidianTemplate`, `:ObsidianFollowLink`

### Conform (formatting)
Keymaps:
- `n/v <leader>cf` → format file or selection (async; LSP fallback enabled)

Behavior:
- Autoformat on save when `g.autoformat = true` (skips while mini.files explorer is open or when `g.skip_formatting` is set).
- Formatters by filetype include: Python (ruff), Ruby (rubocop), Lua (stylua), JS/TS (prettier/dprint), and more.

### Blink.cmp (completion)
Keymaps:
- Preset: `enter` — `<CR>` confirms
- List navigation: `<C-j>` next, `<C-k>` previous
- Signature/doc: auto-show enabled

### Markdown Preview
Keymaps:
- `markdown` only: `n <leader>cp` → `:MarkdownPreviewToggle`

Commands:
- `:MarkdownPreview`, `:MarkdownPreviewStop`, `:MarkdownPreviewToggle`

### Venv Selector (Python)
Keymaps:
- `python` only: `n <leader>vv` → `:VenvSelect`

Commands:
- `:VenvSelect`, `:VenvSelectCached`

### Noice / Lualine / Indent-blankline / Web Devicons
Keymaps:
- No default keymaps (UI/visual plugins)

Commands (Noice):
- `:Noice`, `:NoiceEnable`, `:NoiceDisable`, `:NoiceDismiss`

### Utilities
- Tmux Navigator (defaults provided by plugin):
  - `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` move between Vim splits and tmux panes
  - `<C-\>` previous pane
- Vimux common commands: `:VimuxRunCommand`, `:VimuxPromptCommand`, `:VimuxCloseRunner`
- Ruby helpers:
  - Rails: navigation helpers (e.g. `:A` for alternate file), enhanced `gf` in Rails projects
  - Bundler: `:Bundle`
  - Rake: `:Rake`

## Filetype-specific
- Python (`after/ftplugin/python.lua`):
  - Local indent: 4 spaces
  - Insert-mode abbreviations (buffer-local): `true→True`, `false→False`, `--→#`, `null/none/nil→None`, `function→def`
