local set = vim.opt

set.compatible = false
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.hlsearch = false
set.incsearch = true
set.wrap = false
set.scrolloff = 5
set.cmdheight = 1
set.colorcolumn = "80"
set.signcolumn = "yes"
set.mouse = ""
set.laststatus = 1
set.swapfile = false
vim.g.mapleader = " "

set.completeopt = "menuone,noselect"
set.shortmess:append("c")

if vim.fn.isdirectory(vim.fn.expand("$HOME/.vpm/bin")) ~= 0 then
    vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.expand("$HOME/.vpm/bin")
end

require('vim._core.ui2').enable()

vim.pack.add({
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/junegunn/fzf",
    "https://github.com/junegunn/fzf.vim",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

-- go templ ft
vim.filetype.add({
    extension = {
        templ = "templ",
    },
})

-- keymaps
vim.keymap.set("n", "bd", ":bd<cr>", { silent = true })
vim.keymap.set("n", "bn", ":bn<cr>", { silent = true })
vim.keymap.set("n", "bp", ":bp<cr>", { silent = true })

-- fzf mappings
vim.keymap.set("n", "<leader>ff", ":Files<cr>")
vim.keymap.set("n", "<leader>fb", ":Buffers<cr>")
vim.g.fzf_preview_window = {}
vim.g.fzf_layout = {
    window = {
        width = 0.9,
        height = 0.5,
        border = "sharp",
    }
}
vim.g.fzf_colors = {
    fg = { "fg", "Normal" },
}

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

require "theme"
require "lsp"
require "plugins"
