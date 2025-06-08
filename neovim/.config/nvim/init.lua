local set = vim.opt

set.compatible = false
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.hlsearch = false
set.incsearch = true
set.wrap = false
set.scrolloff = 6
set.cmdheight = 1
set.colorcolumn = "80"
set.signcolumn = "yes"
set.mouse = ""
set.laststatus = 1
set.swapfile = false
vim.g.mapleader = " "

set.completeopt = "menuone,noselect"
set.shortmess:append('c')

if vim.fn.isdirectory(vim.fn.expand("$HOME/.vpm/bin")) ~= 0 then
    vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.expand("$HOME/.vpm/bin")
end

require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    use("lewis6991/gitsigns.nvim")
    use("junegunn/fzf")
    use("junegunn/fzf.vim")
    use {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        run = ":TSUpdate"
    }
    use("jeffkreeftmeijer/vim-dim")
end)

-- termguicolors must be disabled if I want
-- to use the cterm colors
set.termguicolors = false
vim.cmd('colorscheme dim')
vim.api.nvim_set_hl(0, 'SignColumn', {})
vim.api.nvim_set_hl(0, 'MatchParen', {})
vim.api.nvim_set_hl(0, 'NormalFloat', { ctermbg = 0 })
vim.api.nvim_set_hl(0, 'Pmenu', { ctermbg = 0 })
vim.api.nvim_set_hl(0, 'Statement', { ctermfg = 3, bold = false })
vim.api.nvim_set_hl(0, 'Conceal', { ctermfg = 7 })
vim.api.nvim_set_hl(0, 'ColorColumn', { ctermbg = 0 })
vim.api.nvim_set_hl(0, 'LspReferenceTarget', {})

-- when do we see the Ok level??
-- and should it also have the undercurl??
local DiagnosticLevels = { "Error", "Warn", "Info", "Hint" }
for _, level in pairs(DiagnosticLevels) do
    vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. level, vim.tbl_extend("force",
        vim.api.nvim_get_hl(0, { name = "DiagnosticUnderline" .. level }),
        { cterm = { undercurl = true }, undercurl = true }
    ))
end

-- go templ ft
vim.filetype.add({
    extension = {
        templ = "templ",
    },
})

-- keymaps
vim.keymap.set('n', 'bd', ':bd<cr>', { silent = true })
vim.keymap.set('n', 'bn', ':bn<cr>', { silent = true })
vim.keymap.set('n', 'bp', ':bp<cr>', { silent = true })

-- fzf mappings
vim.keymap.set('n', '<leader>ff', ':Files<cr>')
vim.keymap.set('n', '<leader>fb', ':Buffers<cr>')
vim.g.fzf_preview_window = {}
vim.g.fzf_layout = {
    window = {
        width = 0.8,
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

require 'lsp'
require "plugins"
