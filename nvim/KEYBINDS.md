# Keybindings

**Leader key:** `<Space>`

---

### Essential (No Prefix)

| Key | Action |
|-----|--------|
| `jj` / `jk` | Exit insert mode |
| `<C-s>` | Save file |
| `<Esc>` | Clear search highlights |
| `K` | Hover documentation |
| `<C-k>` | Signature help |
| `n` / `N` | Next/prev match (centered) |
| `H` / `L` | Jump to line start/end |
| `X` | Split line (opposite of J) |
| `x` | Delete to black hole register |
| `<C-a>` | Select all |
| `<C-Up/Down>` | Resize window height |
| `<C-Left/Right>` | Resize window width |
| `<C-/>` | Toggle terminal |

---

### Quick Access (`<leader>`)

| Key | Action |
|-----|--------|
| `<leader><space>` | Find files |
| `<leader>/` | Grep search |
| `<leader>,` | Buffers list |
| `<leader>.` | Scratch buffer |
| `<leader>e` | Toggle file explorer (mini.files) |
| `<leader>E` | Toggle file explorer (Snacks) |
| `<leader>q` | Quit |
| `<leader>Q` | Quit all |
| `<leader>?` | Buffer keymaps |
| `<leader>K` | All keymaps |

---

### Buffers (`<leader>b`)

| Key | Action |
|-----|--------|
| `<leader>bb` | Switch buffer |
| `<leader>bd` | Delete buffer |
| `<leader>bo` | Delete other buffers |
| `Q` | Delete buffer |

---

### Code (`<leader>c`)

| Key | Action |
|-----|--------|
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `<leader>cd` | Line diagnostic |
| `<leader>cf` | Format file/range |
| `<leader>cv` | Definition in vertical split |

---

### Diagnostics (`<leader>d`)

| Key | Action |
|-----|--------|
| `<leader>dd` | Workspace diagnostics |
| `<leader>db` | Buffer diagnostics |
| `<leader>dq` | Quickfix list |
| `<leader>dl` | Location list |
| `<leader>dt` | Trouble (workspace) |
| `<leader>dT` | Trouble (buffer) |
| `[d` / `]d` | Prev/next diagnostic |

---

### Files (`<leader>f`)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fc` | Config files |
| `<leader>fg` | Git files |
| `<leader>fp` | Projects |
| `<leader>fR` | Rename file |

---

### Git (`<leader>g`)

| Key | Action |
|-----|--------|
| `<leader>gg` | Lazygit |
| `<leader>gs` | Git status |
| `<leader>gl` | Git log |
| `<leader>gL` | Git log (line) |
| `<leader>gf` | Git log (file) |
| `<leader>gd` | Git diff |
| `<leader>gc` | Checkout branch |
| `<leader>gb` | Blame line |
| `<leader>gB` | Blame buffer |
| `<leader>gD` | Diff HEAD |
| `<leader>gR` | Reset buffer |
| `<leader>gS` | Stage buffer |
| `<leader>go` | Open in browser |
| `<leader>gi` | Issues |
| `<leader>gp` | Pull requests |
| `<leader>ghp` | Preview hunk |
| `<leader>ghP` | Preview hunk inline |
| `<leader>ghs` | Stage hunk |
| `<leader>ghu` | Undo stage hunk |
| `<leader>ghr` | Reset hunk |
| `]h` / `[h` | Next/prev hunk |

---

### LSP (`<leader>l`)

| Key | Action |
|-----|--------|
| `<leader>li` | LSP info |
| `<leader>lr` | LSP restart |
| `<leader>lh` | Toggle inlay hints |
| `<leader>ls` | Document symbols |
| `<leader>lS` | Workspace symbols |
| `<leader>lt` | LSP references (Trouble) |
| `<leader>lT` | Symbols (Trouble) |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `gy` | Go to type definition |
| `gs` | Go to definition in split |

---

### Search (`<leader>s`)

| Key | Action |
|-----|--------|
| `<leader>sg` | Grep search |
| `<leader>sw` | Grep word under cursor |
| `<leader>sb` | Buffer lines |
| `<leader>sB` | Grep open buffers |
| `<leader>sh` | Help |
| `<leader>sk` | Keymaps |
| `<leader>sc` | Commands |
| `<leader>sr` | Registers |
| `<leader>sR` | Resume last search |
| `<leader>sm` | Marks |
| `<leader>sj` | Jumps |
| `<leader>su` | Undo history |
| `<leader>si` | Icons |

---

### Testing (`<leader>t`)

| Key | Action |
|-----|--------|
| `<leader>tt` | Run file tests |
| `<leader>tT` | Run all tests |
| `<leader>tr` | Run nearest test |
| `<leader>tl` | Run last test |
| `<leader>ts` | Toggle test summary |
| `<leader>to` | Show test output |
| `<leader>tO` | Toggle output panel |
| `<leader>tS` | Stop tests |
| `<leader>tw` | Toggle watch mode |

---

### UI Toggles (`<leader>u`)

| Key | Action |
|-----|--------|
| `<leader>us` | Toggle spelling |
| `<leader>uw` | Toggle wrap |
| `<leader>ur` | Toggle relative numbers |
| `<leader>ul` | Toggle line numbers |
| `<leader>uD` | Toggle diagnostics |
| `<leader>uc` | Toggle conceallevel |
| `<leader>ub` | Toggle dark background |
| `<leader>uh` | Toggle inlay hints |
| `<leader>ui` | Toggle indent guides |
| `<leader>ud` | Toggle dim |
| `<leader>uz` | Zen mode |
| `<leader>uZ` | Zoom window |
| `<leader>uC` | Colorschemes |
| `<leader>uN` | Neovim news |

---

### Windows (`<leader>w`)

| Key | Action |
|-----|--------|
| `<leader>wv` | Vertical split |
| `<leader>ws` | Horizontal split |
| `<leader>w=` | Equal window sizes |
| `<leader>wd` | Close window |
| `<leader>ww` | Switch to other window |
| `<leader>wm` | Maximize window |

---

### Obsidian (`<leader>o`)

| Key | Action |
|-----|--------|
| `<leader>on` | New note |
| `<leader>oq` | Quick switch |
| `<leader>og` | Search |
| `<leader>ot` | Today (daily note) |
| `<leader>oy` | Yesterday |
| `<leader>ol` | Follow link |
| `<leader>oL` | Link new |
| `<leader>os` | Browse vault files |
| `<leader>oz` | Grep vault |
| `<leader>oN` | Add note template |
| `<leader>oc` | Add class-note template |
| `<leader>od` | Add daily template |

---

### AI Assistant (`<leader>a`)

| Key | Action |
|-----|--------|
| `<leader>at` | Toggle Claude (Sidekick) |
| `<leader>av` | Send selection to Sidekick |

---

### Markdown (`<leader>m`)

| Key | Action |
|-----|--------|
| `<leader>mp` | Toggle markdown preview |
| `<leader>mr` | Toggle render markdown |

---

### Debugging (`<F*`)

| Key | Action |
|-----|--------|
| `<F5>` | Continue |
| `<F7>` | Step into |
| `<F8>` | Step over |
| `<F9>` | Step out |

---

### Completion (Insert Mode)

| Key | Action |
|-----|--------|
| `<C-Space>` | Show/toggle completion |
| `<C-j>` | Select next item |
| `<C-k>` | Select previous item |
| `<C-b>` | Scroll docs up |

---

### Yank History (Yanky)

| Key | Action |
|-----|--------|
| `p` / `P` | Put after/before |
| `[y` / `]y` | Cycle through yank history |
| `<leader>y` | Copy to clipboard |
| `<leader>Y` | Copy line to clipboard |
| `<leader>d` | Delete to black hole |
