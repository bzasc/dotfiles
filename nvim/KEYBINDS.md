# Keybinds and Plugin Usage

This document lists:
- Global keymaps from `lua/keymaps.lua` and buffer-local/autocmd mappings.
- Keymaps introduced by active plugins in `lua/plugins/`.
- Common user commands provided by those plugins (where applicable).

Leader key: space (`<leader> = " "`).

## Active Plugins (by module)
- LSP: built-in LSP + configs in `lsp/`, completion via `saghen/blink.cmp`, snippets via `L3MON4D3/LuaSnip`.
- Formatting: `stevearc/conform.nvim`.
- UI/Status: `nvim-lualine/lualine.nvim`, `folke/noice.nvim`, `rcarriga/nvim-notify`.
- Treesitter: `nvim-treesitter/nvim-treesitter`, `nvim-treesitter/nvim-treesitter-context`, `windwp/nvim-ts-autotag`.
- Fuzzy finder: `ibhagwan/fzf-lua`.
- Debug: `mfussenegger/nvim-dap`, `igorlfs/nvim-dap-view`, `theHamsta/nvim-dap-virtual-text`, `leoluz/nvim-dap-go`, `mfussenegger/nvim-dap-python`, `jbyuki/one-small-step-for-vimkind`.
- Tasks/Quickfix: `stevearc/overseer.nvim`, `stevearc/quicker.nvim`.
- Movement/Text: `nvim-mini/mini.ai`, `nvim-mini/mini.clue`, `nvim-mini/mini.files`, `nvim-mini/mini.splitjoin`, `nvim-mini/mini.move`, `nvim-mini/mini.bufremove`, `nvim-mini/mini.comment`, `nvim-mini/mini.icons`, `kylechui/nvim-surround`, `gbprod/yanky.nvim`.
- Aesthetics: `lukas-reineke/indent-blankline.nvim`, `nvim-tree/nvim-web-devicons`, `nvim-colorizer.lua`, `sainnhe/sonokai`.
- Obsidian: `epwalsh/obsidian.nvim`.
- Ruby: `tpope/vim-rails`, `tpope/vim-bundler`, `tpope/vim-rake`.
- Python venv: `linux-cultist/venv-selector.nvim`.
- Markdown: `iamcco/markdown-preview.nvim`, `bngarren/checkmate.nvim`.
- Utilities: `nvim-lua/plenary.nvim`, `christoomey/vim-tmux-navigator`, `preservim/vimux`.
- Other: `windwp/nvim-autopairs`, `b0o/SchemaStore.nvim`, `mrcjkb/rustaceanvim`, `szymonwilczek/vim-be-better`.

## Global Keymaps
- `i jk` -> `<Esc>` (quickly leave insert)
- `n <leader>nh` -> `:nohl<CR>` (clear search highlights)
- `n <leader>nd` -> `:NoiceDismiss<CR>` (dismiss Noice message)
- `n x` -> `"_x` (delete without yanking)
- `n n` -> `nzzzv` and `n N` -> `Nzzzv` (center after search navigation)
- `c <CR>` -> adds `zzzv` after `/` searches to center results
- `n <leader>+` -> `<C-a>` (increment number)
- `n <leader>-` -> `<C-x>` (decrement number)
- Splits:
  - `n <leader>sv` -> vertical split
  - `n <leader>ss` -> horizontal split
  - `n <leader>se` -> equalize splits
  - `n <leader>sx` -> close current split
- Wrap:
  - `n <leader>Tw` -> toggle line wrap
- Obsidian templates/search (custom):
  - `n <leader>on` -> `:ObsidianTemplate note` (then clean initial blank lines)
  - `n <leader>oc` -> `:ObsidianTemplate class-note` (then clean initial blank lines)
  - `n <leader>od` -> `:ObsidianTemplate daily` (then clean initial blank lines)
  - `n <leader>os` -> `FzfLua files` in vault
  - `n <leader>oz` -> `FzfLua live_grep` in vault
- `n gs` -> open definition in a vertical split

### Buffer-local / autocmd mappings
- Filetypes `git`, `help`, `man`, `qf`, `scratch`: `n q` -> `:quit<CR>`
- Command-line window: `<S-CR>` executes and stays in cmdwin

## LSP (on_attach)
Defined in `lua/lsp.lua` when a client attaches (capability gated):
- `n [d` / `n ]d` -> previous/next diagnostic
- `n [e` / `n ]e` -> previous/next error
- `n grc` -> color presentation (if supported)
- `n grr` -> references (FzfLua)
- `n gy` -> type definition (FzfLua)
- `n <leader>fs` -> document symbols (FzfLua)
- `n gd` -> go to definition (FzfLua)
- `n gD` -> peek definition (FzfLua)
- `i <C-k>` -> signature help
- `n <leader>cl` -> fix all (ESLint/Stylelint only)

Common commands:
- LSP core: `:LspInfo`, `:LspStart`, `:LspStop`, `:LspRestart`, `:LspLog`

## Plugins — Keymaps and Commands

### fzf-lua
Keymaps:
- `n/x <leader>fb` -> search in current buffer (normal: ripgrep; visual: `blines`)
- `n <leader>fB` -> buffers
- `n <leader>fc` -> highlights
- `n <leader>fd` -> document diagnostics
- `n <leader>ff` -> files
- `n <leader>fg` -> live grep
- `x <leader>fg` -> grep visual selection
- `n <leader>fh` -> help tags
- `n <leader>fr` -> recent files
- `n <leader>fm` -> marks
- `n <leader>f<` -> resume last fzf command
- `n z=` -> spelling suggestions
- `i <C-x><C-f>` -> fuzzy complete path

Picker controls (inside fzf windows):
- Builtin: `<C-/>` help, `<C-a>` fullscreen, `<C-i>` toggle preview
- FZF: `alt-s` toggle, `alt-a` toggle-all, `ctrl-i` toggle preview

Commands:
- `:FzfLua <picker>` — run any picker, e.g. `files`, `live_grep`, `buffers`, `oldfiles`, `help_tags`, `resume`, `lsp_*`.

### Neotest
Keymaps:
- `n <leader>tt` -> run current file
- `n <leader>tT` -> run all tests in cwd
- `n <leader>tr` -> run nearest
- `n <leader>tl` -> run last
- `n <leader>ts` -> toggle summary
- `n <leader>to` -> show output
- `n <leader>tO` -> toggle output panel
- `n <leader>tS` -> stop run
- `n <leader>tw` -> toggle watch (current file)

### mini.files (file explorer)
Keymaps:
- `n <leader>e` -> open explorer at current buffer path
- In mini.files buffers:
  - `?` help
  - `<CR>` open/enter (`go_in_plus`)
  - `<Tab>` go out/up (`go_out_plus`)
  - `<C-w>s` split below and open file; `<C-w>v` split right and open file

### mini.splitjoin
Keymaps:
- `n <leader>cj` -> toggle join/split of code block

### mini.bufremove
Keymaps:
- `n <leader>bd` -> delete current buffer preserving window layout

### nvim-surround
Keymaps:
- `n yz` -> add surround
- `n yzz` -> add surround to current line
- `n yZ` -> add surround linewise
- `n yZZ` -> add surround linewise to current line
- `x Z` -> surround selection

### mini.ai
Text objects:
- `a/i f` -> function (Treesitter)
- `a/i g` -> whole buffer

### mini.move
Keymaps (defaults):
- Normal: `<M-h>` left, `<M-j>` move line down, `<M-k>` move line up, `<M-l>` right
- Visual: `<M-h>`, `<M-j>`, `<M-k>`, `<M-l>` move selection left/down/up/right

### mini.comment
Keymaps (defaults):
- Normal: `gc{motion}` toggle linewise, `gcc` toggle current line
- Normal: `gb{motion}` toggle blockwise
- Visual: `gc` toggle selection linewise, `gb` toggle selection blockwise

### mini.clue
- Shows hints for key sequences; does not create mappings.
- Triggers: `g`, `` ` ``, `"`, `<C-r>` (normal/visual/insert/cmd), `<C-w>`, `i <C-x>`, `z`, `<leader>` (n/visual), `[` and `]`.
- Displays groups: `+ai`, `+buffers`, `+code`, `+debug`, `+find`, `+lsp`, `+obsidian`, `+tests`, `+loclist/quickfix`, `+prev/+next`.

### DAP / dap-view
Keymaps:
- `n <leader>db` -> toggle breakpoint
- `n <leader>dB` -> list breakpoints (FzfLua)
- `n <leader>dc` -> set breakpoint condition
- `n <F5>` -> continue
- `n <F8>` -> step over
- `n <F7>` -> step into
- `n <F9>` -> step out
- `n <leader>dl` -> launch Lua adapter (osv)

Commands:
- nvim-dap: `:DapContinue`, `:DapToggleBreakpoint`, `:DapTerminate`, `:DapStepOver`, `:DapStepInto`, `:DapStepOut`

### Treesitter & Context
Keymaps:
- Incremental selection: `<CR>` to init/increase, `<BS>` to decrease (scope incremental disabled)
- Context jump: `n [c` (expr) -> in diff: previous change; otherwise: jump to upper context

Commands:
- Treesitter core: `:TSUpdate`, `:TSInstall`, `:TSUninstall`, `:TSBufEnable`, `:TSBufDisable`
- Treesitter Context: `:TSContextEnable`, `:TSContextDisable`, `:TSContextToggle`, `:TSContextGoToContext`

### Obsidian
Keymaps (plugin):
- `n <leader>oq` Quick Switch
- `n <leader>og` Search
- `n <leader>ot` Today
- `n <leader>oy` Yesterday
- `n <leader>ol` Follow Link
- `n <leader>oL` Link New
- In vault buffers: `gf` -> pass-through for markdown/wiki links

Commands:
- `:ObsidianQuickSwitch`, `:ObsidianSearch`, `:ObsidianToday`, `:ObsidianYesterday`, `:ObsidianNew`, `:ObsidianLink`, `:ObsidianLinkNew`, `:ObsidianTemplate`, `:ObsidianFollowLink`

Note: `<leader>on` is overridden by the custom template mapping, and `<leader>ot` is also bound by Overseer; whichever loads last will win.

### Conform (formatting)
Keymaps:
- `n/v <leader>cf` -> format file or selection (async; LSP fallback enabled)

Behavior:
- Autoformat on save when `g.autoformat = true` (skips while mini.files explorer is open or when `g.skip_formatting` is set).

### Blink.cmp (completion)
Keymaps:
- Preset: `<CR>` confirms selection
- List navigation: `<C-j>` next, `<C-k>` previous
- Docs: `<C-b>` scroll up, `<C-f>` scroll down

### LuaSnip
Keymaps:
- `i <C-r>s` -> insert on-the-fly snippet
- `i/s <C-c>` -> select choice node (when active)

### Markdown Preview
Keymaps:
- `markdown` only: `n <leader>cp` -> `:MarkdownPreviewToggle`

Commands:
- `:MarkdownPreview`, `:MarkdownPreviewStop`, `:MarkdownPreviewToggle`

### Venv Selector (Python)
Keymaps:
- `python` only: `n <leader>vv` -> `:VenvSelect`

Commands:
- `:VenvSelect`, `:VenvSelectCached`

### Overseer
Keymaps:
- `n <leader>ot` -> toggle task window
- `n <leader>o<` -> restart last task
- `n <leader>or` -> run task

Commands:
- `:OverseerToggle`, `:OverseerRun`, `:OverseerOpen`, `:OverseerClose`

### Quicker (quickfix/loclist)
Keymaps:
- `n <leader>xq` -> toggle quickfix
- `n <leader>xl` -> toggle loclist
- `n <leader>xd` -> toggle diagnostics quickfix
- `n >` -> expand context
- `n <` -> collapse context

### Yanky
Keymaps:
- `n/x p` -> put after (yank history aware)
- `n/x P` -> put before (yank history aware)
- `n =p` -> put linewise below
- `n =P` -> put linewise above
- `n [y` -> cycle forward through yank history
- `n ]y` -> cycle backward through yank history
- `n/x y` -> yank with history tracking

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
  - Insert-mode abbreviations (buffer-local): `true->True`, `false->False`, `--->#`, `null/none/nil->None`, `function->def`
- Ruby (`after/ftplugin/ruby.lua`):
  - Local indent: 2 spaces
  - Insert-mode abbreviations (buffer-local): `null/none/None->nil`, `elif/elseif->elsif`
