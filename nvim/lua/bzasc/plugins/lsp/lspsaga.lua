return {
    "nvimdev/lspsaga.nvim",
    lazy = true,
    dependencies = {
        "neovim/nvim-lspconfig"
    },
    config = function()
        require("lspsaga").setup({})

        vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_type_definition<CR>", { silent = true })
        vim.keymap.set("n", "<leader>pd", "<cmd>Lspsaga peek_type_definition<CR>", { silent = true })
        vim.keymap.set("n", "<leader>lf", "<cmd>Lspsaga finder<CR>", { silent = true })
        vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<cr>", { silent = true })
        vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
        vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })
    end,
}
