-- gitsigns
require("gitsigns").setup()

-- treesitter
require 'nvim-treesitter'.install { 'gleam', 'go', 'python', 'javascript', 'rust', }
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'gleam', 'go', 'python', 'javascript', 'rust', },
    callback = function() vim.treesitter.start() end,
})
