-- gitsigns
require("gitsigns").setup()

-- treesitter
require 'nvim-treesitter'.install { 'gleam', 'go', 'python', 'javascript', 'rust', }

vim.api.nvim_create_augroup('treesitter-setup', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    group = 'treesitter-setup',
    callback = function(args)
        local bufnr = args.buf
        local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
        if not ok or not parser then
            return
        end
        vim.treesitter.start()
    end,
})
