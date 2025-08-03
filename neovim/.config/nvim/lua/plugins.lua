-- gitsigns
require("gitsigns").setup()

-- treesitter
local nvim_treesitter = require('nvim-treesitter')
nvim_treesitter.install { 'gleam', 'go', 'python', 'javascript', 'rust', }
local installed_parsers = nvim_treesitter.get_installed('parsers')

vim.api.nvim_create_augroup('treesitter-setup', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    group = 'treesitter-setup',
    callback = function(args)
        local bufnr = args.buf
        local ft = vim.bo[bufnr].filetype
        if vim.tbl_contains(installed_parsers, ft) then
            vim.treesitter.start()
        end
    end,
})
