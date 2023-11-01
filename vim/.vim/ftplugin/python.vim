let b:ale_linters = ['mypy', 'flake8']
let b:ale_fixers = ['black']
let b:ale_fix_on_save = 0

nmap <leader>f <Plug>(ale_fix)<CR>
nmap <leader>x :! clear;python %<CR>
