let b:ale_linters = ['gopls']
let b:ale_fixers = ['gofmt']

nmap gd <Plug>(ale_go_to_definition)<CR>
nmap <leader>f <Plug>(ale_fix)<CR>
nmap <leader>x :! clear;go run  %<CR>
