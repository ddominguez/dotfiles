local set = vim.opt

set.compatible = false
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.smartindent = true
set.number = true
set.relativenumber = true
set.hlsearch = false
set.incsearch = true
set.wrap = false

set.scrolloff = 8
set.cmdheight = 1
set.colorcolumn = "80"

-- set.termguicolors = true

vim.g.mapleader = " "


require "dave.plugins"
require "dave.theme"
