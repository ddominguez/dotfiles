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

let s:vpm = "$HOME/.vpm/bin"
if (isdirectory(expand(s:vpm)))
    let $PATH .= ':' . expand(s:vpm)
endif

" Plugins
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

" autocomplete
set completeopt=menuone
set shortmess+=c
let g:ale_completion_enabled = 1

let g:ale_fix_on_save = 0
let g:ale_python_auto_virtualenv = 1
" let g:ale_hover_to_floating_preview = 1
" let g:ale_floating_window_border = []

" Adding pyright as a python linter enables pyright-langserver
let g:ale_linters = {
\   'go': ['gopls'],
\   'python': ['flake8', 'pyright'],
\   'rust': ['analyzer'],
\   'typescript': ['eslint', 'tsserver'],
\   'typescriptreact': ['eslint', 'tsserver'],
\}
let g:ale_fixers = {
\   'css': ['prettier'],
\   'go': ['gofmt'],
\   'python': ['black'],
\   'rust': ['rustfmt'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\}

if executable(expand("$VIRTUAL_ENV/bin/python"))
    let g:ale_python_mypy_options = '--python-executable '.$VIRTUAL_ENV.'/bin/python'
endif

au FileType go,python,rust,typescript,typescriptreact
            \ nmap <buffer> <silent> K :ALEHover<CR>

au FileType go,python,rust,typescript,typescriptreact
            \ nmap <buffer> gd <Plug>(ale_go_to_definition)<CR>
au FileType css,go,python,javascript,rust,typescript,typescriptreact
            \ nmap <buffer> <leader>f <Plug>(ale_fix)<CR>

au FileType python nmap <buffer> <leader>x :! clear;python %<CR>
au FileType go nmap <buffer> <leader>x :! clear;go run %<CR>

" filetypes with 2 space tabs
au FileType css,html,javascript,json,typescript,typescriptreact
            \ setlocal shiftwidth=2 tabstop=2 softtabstop=2
