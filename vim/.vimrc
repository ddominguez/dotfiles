syntax enable

filetype plugin indent on

let mapleader = " "
set encoding=utf-8
set nocompatible
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

let vpm_bin = "$HOME/.vpm/bin"
if (isdirectory(expand(vpm_bin)))
    let $PATH .= ':' . expand(vpm_bin)
endif

"Plugins
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'yegappan/lsp'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'gleam-lang/gleam.vim'
Plug 'jeffkreeftmeijer/vim-dim'
call plug#end()

colorscheme grim
set background=dark
hi Identifier cterm=NONE
hi Pmenu ctermbg=0
hi clear SignColumn
hi clear MatchParen
hi SpellBad cterm=underline ctermbg=NONE
hi SpellLocal cterm=underline ctermbg=NONE
hi Constant ctermfg=6
hi Statement cterm=NONE ctermfg=5
hi PreProc cterm=NONE 

"autocomplete
set completeopt=menuone
set shortmess+=c

let biome = exepath("./node_modules/.bin/biome")
let have_biome = executable(biome)
let use_tsserver_format = !have_biome

let lspOpts = #{
\   diagSignErrorText: 'E',
\   diagSignHintText: 'H',
\   diagSignInfoText: 'I',
\   diagSignWarningText: 'W',
\   hoverInPreview: v:false,
\   condensedCompletionMenu: v:true,
\ }

let lspServers = [
\ #{
\     name: 'golang',
\     filetype: ['go', 'gomod'],
\     path: exepath('gopls'),
\     args: ['serve'],
\     syncInit: v:true
\   },
\ #{
\     name: 'pyright',
\     filetype: 'python',
\     path: exepath('pyright-langserver'),
\     args: ['--stdio'],
\     workspaceConfig: #{python: #{pythonPath: exepath('python')}},
\   },
\ #{
\     name: 'rustanalyzer',
\     filetype: 'rust',
\     path: exepath('rust-analyzer'),
\     args: [],
\     syncInit: v:true
\   },
\ #{
\     name: 'tsserver',
\     filetype: ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'],
\     path: exepath('typescript-language-server'),
\     args: ['--stdio'],
\     features: #{documentFormatting: use_tsserver_format},
\   },
\ #{
\     name: 'lexical',
\     filetype: ['elixir', 'eelixir'],
\     path: expand("$HOME/.vpm") . '/packages/lexical/_build/dev/package/lexical/bin/start_lexical.sh',
\     args: [],
\     syncInit: v:true
\   },
\ #{
\     name: 'gleam',
\     debug: v:true,
\     filetype: 'gleam',
\     path: exepath('gleam'),
\     args: ['lsp'],
\     syncInit: v:true,
\   },
\ ]

"ruff is my default python formatter
"Do not use Ruff if black is available
let venvBlack = executable(expand("$VIRTUAL_ENV/bin/black"))
if &ft == 'python' && !venvBlack
    let lspServers += [#{
\     name: 'ruff',
\     filetype: 'python',
\     path: exepath('ruff'),
\     args: ['server'],
\     features: #{codeAction: v:true, documentFormatting: v:true},
\   }]
endif

"Allow biome to handle linting and formatting, if available
if have_biome
    let lspServers += [#{
\     name: 'biome',
\     filetype: ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'],
\     path: biome,
\     args: ['lsp-proxy'],
\     features: #{codeAction: v:true, documentFormatting: v:true},
\   }]
endif

au User LspSetup call LspOptionsSet(lspOpts)
au User LspSetup call LspAddServer(lspServers)
au User LspAttached call LspKeyMaps()

function! LspKeyMaps()
    nmap <buffer> <silent> K :LspHover<CR>
    nmap <buffer> <silent> gd :LspGotoDefinition<CR>
    nmap <buffer> <silent> <leader>e :LspDiagCurrent<CR>
    nmap <buffer> <silent> <leader>q :LspDiagShow<CR>
    nmap <buffer> <silent> <leader>f :LspFormat<CR>
    nmap <buffer> <silent> <leader>gr :LspShowReferences<CR>
    nmap <buffer> <silent> <leader>rn :LspRename<CR>
    nmap <buffer> <silent> <leader>ca :LspCodeAction<CR>
endfunction

nmap bn :bn<CR>
nmap bp :bp<CR>
nmap bd :bd<CR>

let g:fzf_vim = #{preview_window:[]}
nmap <leader>ff :Files<CR>
nmap <leader>fb :Buffers<CR>

if executable('xclip')
    vmap <C-c> :!xclip -f -selection clipboard<CR>
endif

au FileType python nmap <buffer> <leader>x :!clear;python %<CR>
au FileType go nmap <buffer> <leader>x :!clear;go run %<CR>
au FileType help,qf,lspgfm nmap <buffer> q :q<CR>
au FileType qf,lspgfm setlocal wrap linebreak colorcolumn= signcolumn=

"filetypes with 2 space tabs
au FileType css,html,htmldjango,javascript,json,typescript,typescriptreact
            \ setlocal shiftwidth=2 tabstop=2 softtabstop=2
