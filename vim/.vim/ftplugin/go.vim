let b:ale_linters = ['gopls']
let b:ale_fixers = ['gofmt']

nmap <buffer> gd <Plug>(ale_go_to_definition)<CR>
nmap <buffer> <leader>f <Plug>(ale_fix)<CR>
nmap <buffer> <leader>x :! clear;go run  %<CR>
