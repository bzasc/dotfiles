vim.opt_local.tabstop = 4

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO)
end

local function run_cmd(cmd, opts)
  opts = opts or {}
  local on_exit = opts.on_exit or function() end
  local cwd = opts.cwd or vim.fn.getcwd()

  vim.system(cmd, { text = true, cwd = cwd }, function(result)
    vim.schedule(function()
      on_exit(result)
    end)
  end)
end

local function get_package_path()
  local filepath = vim.api.nvim_buf_get_name(0)
  if filepath == "" then
    return "."
  end
  return vim.fn.fnamemodify(filepath, ":h")
end

local function get_module_root()
  local filepath = vim.api.nvim_buf_get_name(0)
  local dir = vim.fn.fnamemodify(filepath, ":h")
  while dir ~= "/" do
    if vim.fn.filereadable(dir .. "/go.mod") == 1 then
      return dir
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
  return vim.fn.getcwd()
end

-- Build & Run
vim.api.nvim_buf_create_user_command(0, "GoBuild", function(opts)
  local args = opts.args ~= "" and opts.args or "./..."
  notify("Building: go build " .. args)
  run_cmd({ "go", "build", args }, {
    cwd = get_module_root(),
    on_exit = function(result)
      if result.code == 0 then
        notify("Build successful")
      else
        notify("Build failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
      end
    end,
  })
end, { nargs = "?", desc = "go build" })

vim.api.nvim_buf_create_user_command(0, "GoRun", function(opts)
  local args = opts.args ~= "" and opts.args or "."
  vim.cmd("split | terminal go run " .. args)
end, { nargs = "?", desc = "go run" })

vim.api.nvim_buf_create_user_command(0, "GoGenerate", function(opts)
  local args = opts.args ~= "" and opts.args or "./..."
  notify("Running: go generate " .. args)
  run_cmd({ "go", "generate", args }, {
    cwd = get_module_root(),
    on_exit = function(result)
      if result.code == 0 then
        notify("Generate completed")
        vim.cmd("checktime")
      else
        notify("Generate failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
      end
    end,
  })
end, { nargs = "?", desc = "go generate" })

-- Testing
vim.api.nvim_buf_create_user_command(0, "GoTest", function(opts)
  local args = opts.args ~= "" and opts.args or "./..."
  vim.cmd("split | terminal go test -v " .. args)
end, { nargs = "?", desc = "go test" })

vim.api.nvim_buf_create_user_command(0, "GoTestFunc", function()
  local func_name = nil
  local node = vim.treesitter.get_node()
  while node do
    if node:type() == "function_declaration" then
      local name_node = node:field("name")[1]
      if name_node then
        func_name = vim.treesitter.get_node_text(name_node, 0)
        break
      end
    end
    node = node:parent()
  end

  if not func_name or not func_name:match("^Test") then
    notify("Cursor not in a Test function", vim.log.levels.WARN)
    return
  end

  local pkg = get_package_path()
  vim.cmd("split | terminal " .. string.format("go test -v -run ^%s$ %s", func_name, pkg))
end, { desc = "Test function under cursor" })

vim.api.nvim_buf_create_user_command(0, "GoTestFile", function()
  vim.cmd("split | terminal go test -v " .. get_package_path())
end, { desc = "Test current package" })

vim.api.nvim_buf_create_user_command(0, "GoCoverage", function(opts)
  local args = opts.args ~= "" and opts.args or "./..."
  vim.cmd("split | terminal go test -coverprofile=coverage.out " .. args .. " && go tool cover -html=coverage.out")
end, { nargs = "?", desc = "go test with coverage" })

-- Module Management
vim.api.nvim_buf_create_user_command(0, "GoModTidy", function()
  notify("Running: go mod tidy")
  run_cmd({ "go", "mod", "tidy" }, {
    cwd = get_module_root(),
    on_exit = function(result)
      if result.code == 0 then
        notify("go mod tidy completed")
        vim.cmd("checktime")
      else
        notify("go mod tidy failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
      end
    end,
  })
end, { desc = "go mod tidy" })

vim.api.nvim_buf_create_user_command(0, "GoModInit", function(opts)
  if opts.args == "" then
    notify("Usage: GoModInit <module-name>", vim.log.levels.WARN)
    return
  end
  notify("Running: go mod init " .. opts.args)
  run_cmd({ "go", "mod", "init", opts.args }, {
    on_exit = function(result)
      if result.code == 0 then
        notify("go mod init completed")
        vim.cmd("checktime")
      else
        notify("go mod init failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
      end
    end,
  })
end, { nargs = 1, desc = "go mod init <module>" })

vim.api.nvim_buf_create_user_command(0, "GoGet", function(opts)
  if opts.args == "" then
    notify("Usage: GoGet <package>", vim.log.levels.WARN)
    return
  end
  notify("Running: go get " .. opts.args)
  run_cmd({ "go", "get", opts.args }, {
    cwd = get_module_root(),
    on_exit = function(result)
      if result.code == 0 then
        notify("go get completed")
        vim.cmd("checktime")
      else
        notify("go get failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
      end
    end,
  })
end, { nargs = 1, desc = "go get <package>" })

-- Code Tools
vim.api.nvim_buf_create_user_command(0, "GoVet", function(opts)
  local args = opts.args ~= "" and opts.args or "./..."
  notify("Running: go vet " .. args)
  run_cmd({ "go", "vet", args }, {
    cwd = get_module_root(),
    on_exit = function(result)
      if result.code == 0 then
        notify("go vet: no issues found")
      else
        notify("go vet:\n" .. (result.stderr or result.stdout), vim.log.levels.WARN)
      end
    end,
  })
end, { nargs = "?", desc = "go vet" })

vim.api.nvim_buf_create_user_command(0, "GoLint", function(opts)
  local args = opts.args ~= "" and opts.args or "./..."
  notify("Running: golangci-lint run " .. args)
  run_cmd({ "golangci-lint", "run", args }, {
    cwd = get_module_root(),
    on_exit = function(result)
      if result.code == 0 then
        notify("golangci-lint: no issues found")
      else
        notify("golangci-lint:\n" .. (result.stdout or result.stderr), vim.log.levels.WARN)
      end
    end,
  })
end, { nargs = "?", desc = "golangci-lint run" })

vim.api.nvim_buf_create_user_command(0, "GoDoc", function(opts)
  if opts.args == "" then
    local word = vim.fn.expand("<cword>")
    if word == "" then
      notify("Usage: GoDoc <symbol>", vim.log.levels.WARN)
      return
    end
    opts.args = word
  end
  vim.cmd("split | terminal go doc " .. opts.args)
end, { nargs = "?", desc = "go doc <symbol>" })

vim.api.nvim_buf_create_user_command(0, "GoImpl", function(opts)
  if opts.args == "" then
    notify("Usage: GoImpl <recv> <interface> (e.g., GoImpl 's *Service' io.Reader)", vim.log.levels.WARN)
    return
  end
  local impl = vim.fn.exepath("impl")
  if impl == "" then
    notify("impl not found. Install with: go install github.com/josharian/impl@latest", vim.log.levels.ERROR)
    return
  end
  local result = vim.fn.system("impl " .. opts.args)
  if vim.v.shell_error == 0 then
    local lines = vim.split(result, "\n")
    local row = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, row, row, false, lines)
    notify("Implementation inserted")
  else
    notify("impl failed: " .. result, vim.log.levels.ERROR)
  end
end, { nargs = "+", desc = "Generate interface implementation" })

vim.api.nvim_buf_create_user_command(0, "GoIfErr", function()
  local iferr = vim.fn.exepath("iferr")
  if iferr == "" then
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local lines = { "if err != nil {", "\treturn err", "}" }
    vim.api.nvim_buf_set_lines(0, row, row, false, lines)
    return
  end
  local pos = vim.fn.getcurpos()
  local result = vim.fn.system(string.format("iferr -pos %d", vim.fn.line2byte(pos[2]) + pos[3] - 1))
  if vim.v.shell_error == 0 and result ~= "" then
    local lines = vim.split(result, "\n")
    vim.api.nvim_buf_set_lines(0, pos[2], pos[2], false, lines)
  else
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local lines = { "if err != nil {", "\treturn err", "}" }
    vim.api.nvim_buf_set_lines(0, row, row, false, lines)
  end
end, { desc = "Insert if err != nil block" })

vim.api.nvim_buf_create_user_command(0, "GoModernize", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  if filepath == "" then
    notify("Buffer has no file path", vim.log.levels.ERROR)
    return
  end
  vim.cmd("silent write")
  notify("GoModernize: running...")
  run_cmd({
    "go",
    "run",
    "golang.org/x/tools/gopls/internal/analysis/modernize/cmd/modernize@latest",
    "-fix",
    filepath,
  }, {
    on_exit = function(result)
      if result.code == 0 then
        vim.cmd("checktime")
        notify("GoModernize: completed")
      else
        notify("GoModernize failed: " .. (result.stderr or result.stdout), vim.log.levels.ERROR)
      end
    end,
  })
end, { desc = "Run gopls modernize -fix on current buffer" })

vim.api.nvim_buf_create_user_command(0, "GoFillStruct", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      return action.title:match("Fill") ~= nil
    end,
    apply = true,
  })
end, { desc = "Fill struct with default values" })

vim.api.nvim_buf_create_user_command(0, "GoAddTags", function(opts)
  local tags = opts.args ~= "" and opts.args or "json"
  local gomodifytags = vim.fn.exepath("gomodifytags")
  if gomodifytags == "" then
    notify(
      "gomodifytags not found. Install with: go install github.com/fatih/gomodifytags@latest",
      vim.log.levels.ERROR
    )
    return
  end
  local filepath = vim.api.nvim_buf_get_name(0)
  local line = vim.fn.line(".")
  vim.cmd("silent write")
  local result = vim.fn.system(string.format("gomodifytags -file %s -line %d -add-tags %s", filepath, line, tags))
  if vim.v.shell_error == 0 then
    vim.cmd("edit!")
    notify("Tags added: " .. tags)
  else
    notify("GoAddTags failed: " .. result, vim.log.levels.ERROR)
  end
end, { nargs = "?", desc = "Add struct tags (default: json)" })

vim.api.nvim_buf_create_user_command(0, "GoRemoveTags", function(opts)
  local tags = opts.args ~= "" and opts.args or "json"
  local gomodifytags = vim.fn.exepath("gomodifytags")
  if gomodifytags == "" then
    notify("gomodifytags not found", vim.log.levels.ERROR)
    return
  end
  local filepath = vim.api.nvim_buf_get_name(0)
  local line = vim.fn.line(".")
  vim.cmd("silent write")
  local result = vim.fn.system(string.format("gomodifytags -file %s -line %d -remove-tags %s", filepath, line, tags))
  if vim.v.shell_error == 0 then
    vim.cmd("edit!")
    notify("Tags removed: " .. tags)
  else
    notify("GoRemoveTags failed: " .. result, vim.log.levels.ERROR)
  end
end, { nargs = "?", desc = "Remove struct tags (default: json)" })

-- Navigation
vim.api.nvim_buf_create_user_command(0, "GoAlt", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  local alt
  if filepath:match("_test%.go$") then
    alt = filepath:gsub("_test%.go$", ".go")
  else
    alt = filepath:gsub("%.go$", "_test.go")
  end
  if vim.fn.filereadable(alt) == 1 then
    vim.cmd("edit " .. alt)
  else
    notify("Alt file not found: " .. alt, vim.log.levels.WARN)
  end
end, { desc = "Switch between test and source file" })

vim.api.nvim_buf_create_user_command(0, "GoAltV", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  local alt
  if filepath:match("_test%.go$") then
    alt = filepath:gsub("_test%.go$", ".go")
  else
    alt = filepath:gsub("%.go$", "_test.go")
  end
  if vim.fn.filereadable(alt) == 1 then
    vim.cmd("vsplit " .. alt)
  else
    notify("Alt file not found: " .. alt, vim.log.levels.WARN)
  end
end, { desc = "Switch to alt file in vsplit" })

-- Binary Installation
local go_tools = {
  { name = "goimports", url = "golang.org/x/tools/cmd/goimports@latest" },
  { name = "gomodifytags", url = "github.com/fatih/gomodifytags@latest" },
  { name = "impl", url = "github.com/josharian/impl@latest" },
  { name = "iferr", url = "github.com/koron/iferr@latest" },
  { name = "gotests", url = "github.com/cweill/gotests/gotests@latest" },
  { name = "golangci-lint", url = "github.com/golangci/golangci-lint/cmd/golangci-lint@latest" },
  { name = "dlv", url = "github.com/go-delve/delve/cmd/dlv@latest" },
  { name = "staticcheck", url = "honnef.co/go/tools/cmd/staticcheck@latest" },
  { name = "govulncheck", url = "golang.org/x/vuln/cmd/govulncheck@latest" },
}

local function install_tools_async(tools, index, action, on_complete)
  index = index or 1
  if index > #tools then
    on_complete()
    return
  end

  local tool = tools[index]
  notify(string.format("[%d/%d] %s: %s", index, #tools, action, tool.name))

  vim.system({ "go", "install", tool.url }, { text = true }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        notify(string.format("Failed to install %s: %s", tool.name, result.stderr or ""), vim.log.levels.ERROR)
      end
      install_tools_async(tools, index + 1, action, on_complete)
    end)
  end)
end

vim.api.nvim_buf_create_user_command(0, "GoInstallBinaries", function()
  notify("Installing Go binaries (this may take a minute)...")
  install_tools_async(go_tools, 1, "Installing", function()
    notify("All Go binaries installed!", vim.log.levels.INFO)
  end)
end, { desc = "Install all Go tool binaries" })

vim.api.nvim_buf_create_user_command(0, "GoUpdateBinaries", function()
  notify("Updating Go binaries (this may take a minute)...")
  install_tools_async(go_tools, 1, "Updating", function()
    notify("All Go binaries updated!", vim.log.levels.INFO)
  end)
end, { desc = "Update all Go tool binaries" })

vim.api.nvim_buf_create_user_command(0, "GoInstallBinary", function(opts)
  if opts.args == "" then
    notify("Available tools: " .. table.concat(
      vim.tbl_map(function(t)
        return t.name
      end, go_tools),
      ", "
    ), vim.log.levels.INFO)
    return
  end
  for _, tool in ipairs(go_tools) do
    if tool.name == opts.args then
      notify("Installing: " .. tool.name .. "...")
      vim.system({ "go", "install", tool.url }, { text = true }, function(result)
        vim.schedule(function()
          if result.code == 0 then
            notify("Installed: " .. tool.name, vim.log.levels.INFO)
          else
            notify("Failed to install " .. tool.name .. ": " .. (result.stderr or ""), vim.log.levels.ERROR)
          end
        end)
      end)
      return
    end
  end
  notify("Unknown tool: " .. opts.args, vim.log.levels.WARN)
end, {
  nargs = "?",
  complete = function()
    return vim.tbl_map(function(t)
      return t.name
    end, go_tools)
  end,
  desc = "Install a specific Go tool binary",
})
