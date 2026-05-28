vim.pack.add({
  "https://github.com/echasnovski/mini.nvim",
})

-- mini.pairs: lazy on first InsertEnter
local _pairs_loaded = false
vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    if _pairs_loaded then
      return
    end
    _pairs_loaded = true
    require("mini.pairs").setup()
  end,
})

-- mini.surround: lazy via stub keymaps (default `s` prefix)
local _surround_loaded = false
local surround_keys = { "sa", "sd", "sf", "sF", "sh", "sr", "sn" }

local function load_surround()
  if _surround_loaded then
    return
  end
  _surround_loaded = true
  for _, k in ipairs(surround_keys) do
    pcall(vim.keymap.del, "n", k)
    pcall(vim.keymap.del, "x", k)
  end
  require("mini.surround").setup()
end

for _, k in ipairs(surround_keys) do
  vim.keymap.set({ "n", "x" }, k, function()
    load_surround()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(k, true, false, true), "m", false)
  end, { desc = "Surround (lazy)" })
end
