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
set wildoptions=pum
set signcolumn=yes
set nobackup
set noswapfile
set nowritebackup
set ttyfast
set termguicolors

let vpm_bin = "$HOME/.vpm/bin"
if (isdirectory(expand(vpm_bin)))
    let $PATH .= ':' . expand(vpm_bin)
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
Plug 'lighthaus-theme/vim-lighthaus'
call plug#end()

set background=dark
colorscheme lighthaus


" autocomplete
set completeopt=menuone
set shortmess+=c

let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 0
let g:ale_python_auto_virtualenv = 1
let g:ale_linters_explicit = 1

let g:ale_linters = {
\   'go': ['gopls'],
\   'python': ['flake8', 'pyright'],
\   'ruby': ['ruby'],
\   'rust': ['analyzer'],
\   'typescript': ['tsserver'],
\   'typescriptreact': ['tsserver'],
\}
let g:ale_fixers = {
\   'css': ['prettier'],
\   'go': ['gofmt'],
\   'python': ['ruff_format'],
\   'rust': ['rustfmt'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\}

function FindConfigFile(...)
    for f in a:000
        if filereadable(getcwd().'/'.f)
            return 1
        endif
    endfor
    return 0
endfunction

if FindConfigFile('.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json')
    let g:ale_linters['typescript'] += ['eslint']
    let g:ale_linters['typescriptreact'] += ['eslint']
endif

if FindConfigFile('biome.json')
    " let g:ale_linters['typescript'] += ['biome']
    " let g:ale_linters['typescriptreact'] += ['biome']
    let g:ale_fixers = {'typescript': ['biome'], 'typescriptreact': ['biome']}
endif

if FindConfigFile('deno.json')
    " deno has its own lsp, linter, and formatter
    let g:ale_linters = {'typescript': ['deno']}
    let g:ale_fixers = {'typescript': ['deno']}
endif

if executable(expand("$VIRTUAL_ENV/bin/python"))
    let g:ale_python_mypy_options = '--python-executable '.$VIRTUAL_ENV.'/bin/python'
endif

au FileType ale-info,ale-preview.message setlocal wrap linebreak
au FileType css,html,htmldjango,go,python,rust,typescript,typescriptreact
            \ nmap <buffer> <silent> K :ALEHover<CR>
au FileType css,html,htmldjango,go,python,rust,typescript,typescriptreact
            \ nmap <buffer> <silent> <leader>q :ALEDetail<CR>
au FileType go,python,rust,typescript,typescriptreact
            \ nmap <buffer> gd <Plug>(ale_go_to_definition)<CR>
au FileType css,go,python,javascript,rust,typescript,typescriptreact
            \ nmap <buffer> <leader>f <Plug>(ale_fix)<CR>

" fzf commands
nmap <leader>ff :Files<CR>
nmap <leader>fb :Buffers<CR>

au FileType python nmap <buffer> <leader>x :!clear;python %<CR>
au FileType go nmap <buffer> <leader>x :!clear;go run %<CR>
au FileType help nmap <buffer> q :q<CR>

" filetypes with 2 space tabs
au FileType css,html,htmldjango,javascript,json,typescript,typescriptreact
            \ setlocal shiftwidth=2 tabstop=2 softtabstop=2
