local set = vim.opt

set.compatible = false
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.hlsearch = false
set.incsearch = true
set.wrap = false
set.scrolloff = 6
set.cmdheight = 1
set.colorcolumn = "80"
set.signcolumn = "yes"
set.termguicolors = true
set.mouse = ""
set.laststatus = 1
set.swapfile = false
vim.g.mapleader = " "

set.completeopt = "menuone"
set.shortmess:append('c')

-- configure 2 space indentation
vim.api.nvim_create_augroup('setIndent', { clear = true })
vim.api.nvim_create_autocmd('Filetype', {
    group = 'setIndent',
    pattern = {
        'css', 'gleam', 'html', 'htmldjango', 'javascript', 'javascriptreact',
        'typescript', 'typescriptreact', 'json', 'jsonc'
    },
    command = 'setlocal shiftwidth=2 tabstop=2 softtabstop=2'
})
vim.cmd('au FileType gleam setlocal commentstring=//%s smartindent')
vim.cmd('au FileType qf setlocal wrap linebreak')

-- vim packages
-- Find out if this could replace Mason
if vim.fn.isdirectory(vim.fn.expand("$HOME/.vpm/bin")) ~= 0 then
    vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.expand("$HOME/.vpm/bin")
end

require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    use("neovim/nvim-lspconfig")
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("lewis6991/gitsigns.nvim")
    use("junegunn/fzf")
    use("junegunn/fzf.vim")
    use("stevearc/conform.nvim")
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use("ayu-theme/ayu-vim")
end)

vim.api.nvim_set_var('ayucolor', 'mirage')
vim.cmd('colorscheme ayu')
vim.api.nvim_set_hl(0, "Normal", { bg = "#1F2430" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "#1F2430" })
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Pmenu" })
vim.api.nvim_set_hl(0, "MatchParen", {})
vim.api.nvim_set_hl(0, "typescriptParens", { link = "MatchParen" })

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
vim.cmd('au FileType help,qf nmap <buffer> q :q<CR>')
vim.cmd('au FileType gleam nmap <buffer> <leader>x :!gleam run<CR>')
vim.cmd('au FileType python nmap <buffer> <leader>x :!python %<CR>')

-- fzf mappings
vim.keymap.set('n', '<leader>ff', ':Files<cr>')
vim.keymap.set('n', '<leader>fb', ':Buffers<cr>')
vim.g.fzf_preview_window = {}

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

require "plugins_setup"
