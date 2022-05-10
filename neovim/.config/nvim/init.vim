" Include python venv if activated
if !empty($VIRTUAL_ENV)
    set path+=$VIRTUAL_ENV
    let g:python3_host_prog = $VIRTUAL_ENV."/bin/python3"
endif

syntax enable       " syntax highlighting

set nocompatible    " disable compatibility to old-time vi
set showmatch       " show matching
set ignorecase      " case insensitive
set nohlsearch      " disable highlight search
set incsearch       " incremental search
set tabstop=4       " number of columns occupied by tab
set softtabstop=4   " see multiple spaces as tabstops
set expandtab       " converts tabs to whitespaces
set shiftwidth=4    " width for autoindents
set autoindent      " indent new line
set smartindent
set number          " line numbers
set nowrap

set scrolloff=8
set cmdheight=1
set colorcolumn=80

set wildmode=longest,list,full
set wildmenu
" ignore file patterns
set wildignore+=*.pyc
set wildignore+=**/__pycache__/**
set wildignore+=**/node_modules/**
set wildignore+=**/.git/**

" Plugins
call plug#begin()
" Color scheme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" LSP config and autocomplete
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
call plug#end()


colorscheme tokyonight

" Load LSP
lua require('lsp')

