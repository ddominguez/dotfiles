local lsp = require("lsp-zero")
local util = require("lspconfig.util")

-- format_python will execute a python formatter that exists in vim.env.PATH
local format_python = function()
    if vim.fn.exepath("black") ~= "" then
        vim.cmd("! black %")
        return
    end
    vim.notify("Formatter not found", vim.log.levels.WARN)
end

lsp.preset("recommended")

lsp.ensure_installed({
    "html",
    "pyright",
    "lua_ls",
    "tsserver"
})

lsp.on_attach(function(client, bufnr)
    if util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
        if client.name == "tsserver" then
            client.stop()
            return
        end
    end
    local opts = { buffer = bufnr, remap = false }
    local bind = vim.keymap.set

    bind("n", "<leader>e", function() vim.diagnostic.open_float() end, opts)
    bind("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    bind("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    bind("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    bind("n", "gd", function() vim.lsp.buf.definition() end, opts)
    bind("n", "K", function() vim.lsp.buf.hover() end, opts)
    bind("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    bind("n", "<leader>D", function() vim.lsp.buf.type_definition() end, opts)
    bind("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    bind("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    bind("n", "<leader>f", function()
        local ft = vim.bo.filetype
        if ft == "python" then
            format_python()
        else
            vim.lsp.buf.format { async = true }
        end
    end, opts)
end)

lsp.configure("html", {
    filetypes = { "html", "htmldjango" },
    settings = {
        html = {
            format = {
                templating = true,
                wrapLineLength = 0,
                wrapAttributes = "preserve-aligned",
            }
        }
    }
})

lsp.configure("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})

lsp.configure("tsserver", {
    root_dir = util.root_pattern("package.json", "tsconfig.json"),
    single_file_support = false
})

lsp.configure("denols", {
    root_dir = util.root_pattern("deno.json", "deno.jsonc"),
})

--  Language servers that exist locally
--  and not installed via mason or nvim plugin manager
local installed_servers = {}

if vim.fn.exepath("gopls") ~= "" then
    table.insert(installed_servers, "gopls")
end

if vim.fn.exepath("deno") ~= "" and util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
    table.insert(installed_servers, "denols")
end

if vim.fn.exepath("rust-analyzer") ~= "" then
    table.insert(installed_servers, "rust_analyzer")
end

if next(installed_servers) ~= nil then
    installed_servers.force = true
    lsp.setup_servers(installed_servers)
end

lsp.setup()
