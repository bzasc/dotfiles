-- Configuration for the python debugger
-- * configures debugpy for us
-- * uses the debugpy installation from mason
return {
  "mfussenegger/nvim-dap-python",
  dependencies = "mfussenegger/nvim-dap",
  ft = "python",
  config = function()
    -- fix: E5108: Error executing lua .../Local/nvim-data/lazy/nvim-dap-ui/lua/dapui/controls.lua:14: attempt to index local 'element' (a nil value)
    -- see: https://github.com/rcarriga/nvim-dap-ui/issues/279#issuecomment-1596258077
    require("dapui").setup()
    -- Prefer Mason's debugpy Python if available. Some Mason versions
    -- changed the package API, so we avoid calling missing methods.
    local uv = vim.uv or vim.loop
    local function path_exists(p)
      return p and uv and uv.fs_stat and uv.fs_stat(p) ~= nil
    end

    local py
    -- 1) Respect explicit override via env
    if vim.env.PYTHON_DEBUGPY and vim.fn.executable(vim.env.PYTHON_DEBUGPY) == 1 then
      py = vim.env.PYTHON_DEBUGPY
    end

    -- 2) Try Mason registry (if present), but guard against API changes
    if not py then
      local ok, mason_registry = pcall(require, "mason-registry")
      if ok then
        local pkg = nil
        if type(mason_registry.get_package) == "function" then
          local ok_pkg, p = pcall(mason_registry.get_package, "debugpy")
          if ok_pkg then
            pkg = p
          end
        end
        if pkg then
          local install_path
          if type(pkg.get_install_path) == "function" then
            install_path = pkg:get_install_path()
          elseif type(pkg.install_path) == "string" then
            install_path = pkg.install_path
          end
          if install_path then
            if path_exists(install_path .. "/venv/bin/python") then
              py = install_path .. "/venv/bin/python"
            end
          end
        end
      end
    end

    -- 3) Fallback to default Mason install path
    if not py then
      local base = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/"
      if path_exists(base .. "bin/python") then
        py = base .. "bin/python"
      end
    end

    -- 4) Last resort: system Python
    if not py then
      py = vim.fn.exepath("python3")
    end

    require("dap-python").setup(py, {})
  end,
}
