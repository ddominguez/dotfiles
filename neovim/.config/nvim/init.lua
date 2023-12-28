local set = vim.opt

set.compatible = false
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.smartindent = true
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
vim.g.mapleader = " "

set.completeopt="menuone"
vim.cmd([[set shortmess+=c]])

set.background = "dark"
vim.cmd([[colorscheme habamax]])
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "MatchParen", { bg = "#eeeeee", fg = "#5f8787", bold = false, reverse = true })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#111111" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#111111" })

-- configure 2 space indentation
vim.api.nvim_create_augroup('setIndent', { clear = true })
vim.api.nvim_create_autocmd('Filetype', {
    group = 'setIndent',
    pattern = {
        'css', 'html', 'htmldjango', 'javascript', 'javascriptreact',
        'typescript', 'typescriptreact', 'json', 'jsonc'
    },
    command = 'setlocal shiftwidth=2 tabstop=2 softtabstop=2'
})

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
    use('saadparwaiz1/cmp_luasnip')
    use('L3MON4D3/LuaSnip')
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    }
    use("lewis6991/gitsigns.nvim")
    use("junegunn/fzf")
    use("junegunn/fzf.vim")
end)

require "plugins_setup"
