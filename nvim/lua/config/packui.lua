local api = vim.api
local ns = api.nvim_create_namespace("pack_ui")

local HL = {
  PackUiHeader = "Title",
  PackUiButton = "Function",
  PackUiLoaded = "String",
  PackUiUnloaded = "Comment",
  PackUiVersion = "Number",
  PackUiSection = "Label",
  PackUiSep = "FloatBorder",
  PackUiDetail = "Comment",
  PackUiHelp = "SpecialComment",
}

local state = { bufnr = nil, winid = nil, expanded = {}, help = false, tags = {} }

local function git_tag(path)
  if not path or state.tags[path] ~= nil then
    return state.tags[path] or nil
  end
  local r = vim.fn.system("git -C " .. vim.fn.shellescape(path) .. " describe --tags --exact-match HEAD 2>/dev/null")
  state.tags[path] = vim.v.shell_error == 0 and vim.trim(r) or false
  return state.tags[path] or nil
end

local function render()
  if not (state.bufnr and api.nvim_buf_is_valid(state.bufnr)) then
    return
  end

  local plugins = vim.pack.get(nil, { info = false })
  local loaded, unloaded = {}, {}
  for _, p in ipairs(plugins) do
    table.insert(p.active and loaded or unloaded, p)
  end
  local cmp = function(a, b)
    return a.spec.name < b.spec.name
  end
  table.sort(loaded, cmp)
  table.sort(unloaded, cmp)

  local lines, marks = {}, {}
  state.lmap = {} -- lnum (1-based) -> plugin name

  local function put(text, hl_group)
    lines[#lines + 1] = text
    if hl_group then
      marks[#marks + 1] = { #lines - 1, 0, #text, hl_group }
    end
  end
  local function hl(lnum, s, e, group)
    marks[#marks + 1] = { lnum, s, e, group }
  end

  local w = state.winid and api.nvim_win_get_width(state.winid) or 80

  -- Header
  put((" vim.pack  %d plugins  (%d loaded, %d not loaded)"):format(#plugins, #loaded, #unloaded), "PackUiHeader")
  put(" " .. ("─"):rep(w - 1), "PackUiSep")

  -- Action bar  (only actions that make sense inside the UI)
  local bar = "  [U] Update All   [u] Update   [D] Delete   [L] Log   [?] Help"
  put(bar)
  for s, e in bar:gmatch("()%[.-%]()") do
    hl(#lines - 1, s - 1, e - 1, "PackUiButton")
  end

  -- Help section
  if state.help then
    put("")
    put("  Keymaps:", "PackUiHelp")
    put("    U        Update all plugins", "PackUiHelp")
    put("    u        Update plugin under cursor", "PackUiHelp")
    put("    D        Delete plugin under cursor (inactive only)", "PackUiHelp")
    put("    L        Open update log", "PackUiHelp")
    put("    <CR>     Toggle path / rev details", "PackUiHelp")
    put("    ]] / [[  Jump to next / prev plugin", "PackUiHelp")
    put("    q / <Esc>  Close", "PackUiHelp")
  end

  -- max name width for column alignment
  local max_w = vim.iter(plugins):fold(0, function(acc, p)
    return math.max(acc, #p.spec.name)
  end)

  local function render_plugin(p, icon, grp)
    local name = p.spec.name
    local ver = ""
    if p.spec.version then
      ver = git_tag(p.path) or tostring(p.spec.version)
    elseif p.rev then
      ver = p.rev:sub(1, 7)
    end
    local pad = (" "):rep(max_w - #name + 2)
    put(("  %s %s%s%s"):format(icon, name, pad, ver))

    local lnum = #lines - 1
    state.lmap[lnum + 1] = name
    hl(lnum, 2, 2 + #icon, grp)
    hl(lnum, 3 + #icon, 3 + #icon + #name, grp)
    if #ver > 0 then
      local vs = 3 + #icon + #name + #pad
      hl(lnum, vs, vs + #ver, "PackUiVersion")
    end

    if state.expanded[name] then
      put(("    path : %s"):format(p.path or "?"), "PackUiDetail")
      put(("    src  : %s"):format(p.spec.src or "?"), "PackUiDetail")
      if p.rev then
        put(("    rev  : %s"):format(p.rev), "PackUiDetail")
      end
    end
  end

  put("")
  put((" Loaded (%d)"):format(#loaded), "PackUiSection")
  for _, p in ipairs(loaded) do
    render_plugin(p, "●", "PackUiLoaded")
  end

  if #unloaded > 0 then
    put("")
    put((" Not Loaded (%d)  — safe to delete with D"):format(#unloaded), "PackUiSection")
    for _, p in ipairs(unloaded) do
      render_plugin(p, "○", "PackUiUnloaded")
    end
  end

  vim.bo[state.bufnr].modifiable = true
  api.nvim_buf_set_lines(state.bufnr, 0, -1, false, lines)
  vim.bo[state.bufnr].modifiable = false
  api.nvim_buf_clear_namespace(state.bufnr, ns, 0, -1)
  for _, m in ipairs(marks) do
    api.nvim_buf_set_extmark(state.bufnr, ns, m[1], m[2], { end_col = m[3], hl_group = m[4] })
  end
end

local function cursor_plugin()
  if not (state.winid and api.nvim_win_is_valid(state.winid)) then
    return
  end
  return state.lmap[api.nvim_win_get_cursor(state.winid)[1]]
end

local function jump(dir)
  if not (state.winid and api.nvim_win_is_valid(state.winid)) then
    return
  end
  local row = api.nvim_win_get_cursor(state.winid)[1]
  local plines = vim.tbl_keys(state.lmap)
  table.sort(plines)
  local target
  if dir > 0 then
    target = vim.iter(plines):find(function(l)
      return l > row
    end) or plines[1]
  else
    for i = #plines, 1, -1 do
      if plines[i] < row then
        target = plines[i]
        break
      end
    end
    target = target or plines[#plines]
  end
  if target then
    api.nvim_win_set_cursor(state.winid, { target, 0 })
  end
end

local function close()
  if state.winid and api.nvim_win_is_valid(state.winid) then
    api.nvim_win_close(state.winid, true)
  end
  state.winid, state.bufnr, state.expanded, state.help = nil, nil, {}, false
end

local function open()
  if state.winid and api.nvim_win_is_valid(state.winid) then
    api.nvim_set_current_win(state.winid)
    return
  end

  for g, link in pairs(HL) do
    api.nvim_set_hl(0, g, { link = link, default = true })
  end

  state.bufnr = api.nvim_create_buf(false, true)
  vim.bo[state.bufnr].buftype = "nofile"
  vim.bo[state.bufnr].bufhidden = "wipe"
  vim.bo[state.bufnr].filetype = "pack-ui"

  local cols, rows = vim.o.columns, vim.o.lines
  local W = math.min(cols - 4, math.max(math.floor(cols * 0.8), 60))
  local H = math.min(rows - 4, math.max(math.floor(rows * 0.8), 20))
  state.winid = api.nvim_open_win(state.bufnr, true, {
    relative = "editor",
    width = W,
    height = H,
    row = math.floor((rows - H) / 2),
    col = math.floor((cols - W) / 2),
    style = "minimal",
    border = "rounded",
    title = " vim.pack ",
    title_pos = "center",
  })
  vim.wo[state.winid].cursorline = true
  vim.wo[state.winid].wrap = false

  render()

  local o = { buffer = state.bufnr, silent = true, nowait = true }

  vim.keymap.set("n", "q", close, o)
  vim.keymap.set("n", "<Esc>", close, o)
  vim.keymap.set("n", "?", function()
    state.help = not state.help
    render()
  end, o)
  vim.keymap.set("n", "]]", function()
    jump(1)
  end, o)
  vim.keymap.set("n", "[[", function()
    jump(-1)
  end, o)

  vim.keymap.set("n", "<CR>", function()
    local name = cursor_plugin()
    if not name then
      return
    end
    state.expanded[name] = not state.expanded[name]
    render()
    for lnum, n in pairs(state.lmap) do
      if n == name then
        api.nvim_win_set_cursor(state.winid, { lnum, 0 })
        break
      end
    end
  end, o)

  vim.keymap.set("n", "U", function()
    close()
    vim.pack.update()
  end, o)

  vim.keymap.set("n", "u", function()
    local name = cursor_plugin()
    if not name then
      vim.notify("vim.pack: no plugin under cursor", vim.log.levels.WARN)
      return
    end
    close()
    vim.pack.update({ name })
  end, o)

  vim.keymap.set("n", "D", function()
    local name = cursor_plugin()
    if not name then
      vim.notify("vim.pack: no plugin under cursor", vim.log.levels.WARN)
      return
    end
    local pdata = vim.pack.get({ name }, { info = false })
    if pdata[1] and pdata[1].active then
      vim.notify(("vim.pack: %s is active — remove it from your config first"):format(name), vim.log.levels.WARN)
      return
    end
    if vim.fn.confirm(("Delete %s?"):format(name), "&Yes\n&No", 2) == 1 then
      close()
      local ok, err = pcall(vim.pack.del, { name })
      vim.notify(
        ok and ("vim.pack: deleted %s"):format(name) or "vim.pack: " .. tostring(err),
        ok and vim.log.levels.INFO or vim.log.levels.ERROR
      )
    end
  end, o)

  vim.keymap.set("n", "L", function()
    close()
    local log = vim.fs.joinpath(vim.fn.stdpath("log"), "nvim-pack.log")
    if vim.uv.fs_stat(log) then
      vim.cmd.edit(log)
    else
      vim.notify("vim.pack: no log file yet", vim.log.levels.INFO)
    end
  end, o)

  api.nvim_create_autocmd("WinClosed", {
    buffer = state.bufnr,
    once = true,
    callback = function(ev)
      if tonumber(ev.match) == state.winid then
        state.winid, state.bufnr, state.expanded, state.help = nil, nil, {}, false
      end
    end,
  })
end

vim.api.nvim_create_user_command("Pack", open, { desc = "Open vim.pack plugin manager UI" })
