local set = vim.opt

set.compatible = false
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.smartindent = true
-- set.number = true
-- set.relativenumber = true
set.hlsearch = false
set.incsearch = true
set.wrap = false

set.scrolloff = 6
set.cmdheight = 1
set.colorcolumn = "80"
set.signcolumn = "yes"

set.termguicolors = true

set.mouse = ""

vim.g.mapleader = " "

-- hide the status line
set.laststatus = 0

-- configure 2 space indentation
vim.api.nvim_create_augroup('setIndent', { clear = true })
vim.api.nvim_create_autocmd('Filetype', {
    group = 'setIndent',
    pattern = { 'css', 'javascript', 'typescript', 'json', 'jsonc' },
    command = 'setlocal shiftwidth=2 tabstop=2 softtabstop=2'
})


require "dave.plugins"
require "dave.theme"
