syntax enable

filetype plugin indent on

let mapleader = " "
set encoding=utf-8
set nocompatible
set autoindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noignorecase
set hlsearch
set incsearch
set nonumber
set nowrap
set scrolloff=6
set colorcolumn=80
set showcmd
set showmode
set wildmenu
set signcolumn=yes
set nobackup
set noswapfile
set nowritebackup
set ttyfast
set termguicolors

set background=dark
colorscheme retrobox

hi clear SignColumn

" nable omni-completion
set omnifunc=syntaxcomplete#Complete

" Plugins
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'dense-analysis/ale'
call plug#end()

let g:ale_fix_on_save = 0
let g:ale_completion_enabled = 0
let g:ale_linters = {
\   'go': ['gopls'],
\   'python': ['flake8', 'mypy'],
\}
let g:ale_fixers = {
\   'go': ['gofmt'],
\   'python': ['black'],
\}

au FileType go nmap <buffer> gd <Plug>(ale_go_to_definition)<CR>
au FileType go,python nmap <buffer> <leader>f <Plug>(ale_fix)<CR>
au FileType python nmap <buffer> <leader>x :! clear;python %<CR>
au FileType go nmap <buffer> <leader>x :! clear;go run %<CR>
au FileTYPE html setlocal shiftwidth=2 tabstop=2 softtabstop=2
