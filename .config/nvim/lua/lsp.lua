--- Lsp and Diagnostic Config
--- https://neovim.io/doc/user/lsp.html
--- https://neovim.io/doc/user/diagnostic.html


--- Check if an executable exists.
--- @param exe string
--- @return boolean
local exe_exists = function(exe)
    return vim.fn.executable(exe) == 1
end

local lsps = {
    'gleam',
    'gopls',
    'lua_ls',
    'pyright',
    'rust_analyzer',
    'ts_ls',
    'zls'
}

local biome_cli = vim.fn.getcwd() .. "/node_modules/.bin/biome"
if exe_exists(biome_cli) then
    table.insert(lsps, 'biome')
end

-- ruff is my default python formatter
-- If a project is using black, then I'm assuming we are NOT using ruff
if not exe_exists(vim.fn.expand("$VIRTUAL_ENV/bin/black")) then
    table.insert(lsps, 'ruff')
end

if exe_exists(vim.fn.expand("$VIRTUAL_ENV/bin/pyrefly")) then
    lsps = vim.tbl_filter(function(lsp)
        return lsp ~= 'pyright'
    end, lsps)
    table.insert(lsps, 'pyrefly')
end

vim.lsp.enable(lsps)

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end

        if client:supports_method('textDocument/formatting') then
            -- prevent formatting from multiple clients
            if client.name == 'ts_ls' and exe_exists(biome_cli) then
                client.server_capabilities.documentFormattingProvider = false
            end
        end

        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gf', function()
            vim.lsp.buf.format { async = true }
        end, opts)
        vim.keymap.set('n', 'K', function()
            vim.lsp.buf.hover { border = 'single' }
        end, opts)
    end,
})

vim.keymap.set('n', 'grq', vim.diagnostic.setqflist)
vim.keymap.set('n', 'gre', function()
    vim.diagnostic.open_float { border = 'single' }
end)
