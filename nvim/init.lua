-- Luarocks path (needed for magick/image support).
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
package.cpath = package.cpath .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/lib/lua/5.1/?.so"

-- Global variables.
vim.g.projects_dir = vim.env.HOME .. "/dev"

-- Install Lazy.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp = vim.opt.rtp ^ lazypath

-- Bootstrap tree-sitter-cli if cargo is available
if vim.fn.executable("tree-sitter") == 0 and vim.fn.executable("cargo") == 1 then
  vim.notify("Installing tree-sitter-cli via cargo...", vim.log.levels.INFO)
  vim.fn.jobstart({ "cargo", "install", "--locked", "tree-sitter-cli" }, {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify("tree-sitter-cli installed successfully!", vim.log.levels.INFO)
      else
        vim.notify("Failed to install tree-sitter-cli", vim.log.levels.WARN)
      end
    end,
  })
end

local plugins = "plugins"

-- General setup and goodies (order matters here).
require("options")
require("keymaps")
require("commands")
require("autocmds")
require("utils")
require("marks")

-- Configure plugins.
require("lazy").setup(plugins, {
  ui = {
    border = "rounded",
  },
  dev = { path = vim.g.projects_dir },
  install = {
    missing = true,
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  -- None of my plugins use luarocks so disable this.
  rocks = {
    enabled = false,
  },
  performance = {
    rtp = {
      -- Stuff I don't use.
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Interactive textual undotree:
vim.cmd.packadd("nvim.undotree")
