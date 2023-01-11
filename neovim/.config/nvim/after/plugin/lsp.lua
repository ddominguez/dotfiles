local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    "html",
    "pyright",
    "sumneko_lua",
    "tsserver"
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}
    local bind = vim.keymap.set

    bind("n", "<leader>e", function() vim.diagnostic.open_float() end, opts)
    bind("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    bind("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    bind("n", "<leader>q", function() vim.diagnostic.setloclist() end, opts)

    bind("n", "gD", function () vim.lsp.buf.declaration() end, opts)
    bind("n", "gd", function() vim.lsp.buf.definition() end, opts)
    bind("n", "K", function() vim.lsp.buf.hover() end, opts)
    bind("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    bind("n", "<leader>D", function() vim.lsp.buf.type_definition() end, opts)
    bind("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    bind("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    bind("n", "<leader>f", function() vim.lsp.buf.formatting() end, opts)

end)

lsp.configure("sumneko_lua", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})

lsp.setup()

