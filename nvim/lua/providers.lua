-- Providers configuration (Ruby, etc.)

-- Ruby provider: prefer env override, then auto-discover
do
  local env_path = vim.env.RUBY_HOST_PROG
  if env_path and #env_path > 0 then
    vim.g.ruby_host_prog = env_path
  else
    if vim.fn.executable("neovim-ruby-host") == 1 then
      vim.g.ruby_host_prog = vim.fn.exepath("neovim-ruby-host")
    end
  end
end

-- Python provider: prefer env override; fallback to system python3
do
  local env_path = vim.env.PYTHON3_HOST_PROG
  if env_path and #env_path > 0 then
    vim.g.python3_host_prog = env_path
  elseif vim.fn.executable("python3") == 1 then
    vim.g.python3_host_prog = vim.fn.exepath("python3")
  end
end

return {}
