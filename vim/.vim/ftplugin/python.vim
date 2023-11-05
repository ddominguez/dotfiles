let b:ale_linters = ['mypy', 'flake8']
let b:ale_fixers = ['black']

nmap <buffer> <leader>f <Plug>(ale_fix)<CR>
nmap <buffer> <leader>x :! clear;python %<CR>
