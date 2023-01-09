require("gitsigns").setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local opts = {buffer = bufnr, remap = false}
        local bind = vim.keymap.set

        bind('n', '<leader>hb', function() gs.blame_line{full=true} end, opts)
    end
}
