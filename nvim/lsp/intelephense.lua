---@type vim.lsp.Config
local function get_license()
  local path = os.getenv("HOME") .. "/intelephense/license.txt"
  local file = io.open(path, "rb")
  if not file then
    return nil
  end

  local content = file:read("*a")
  file:close()

  return string.gsub(content, "%s+", "")
end

return {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php", "blade" },
  root_markers = { "composer.json", ".git" },
  init_options = {
    licenceKey = get_license(),
  },
}
