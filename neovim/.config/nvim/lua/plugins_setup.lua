-- gitsigns setup
require("gitsigns").setup()

-- lsp and autocomplete setup
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require('lspconfig')
local lsp_util = require('lspconfig.util')

--- Checks if current working dir is a deno project.
---@return boolean
local is_deno_proj = function()
    if lsp_util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
        return true
    end
    return false
end
local is_deno = is_deno_proj()

--- Checks if an executable exists.
---@param exe string
---@return boolean
local exe_exists = function(exe)
    return vim.fn.executable(exe) == 1
end

local lsp_settings = {
    cssls = {},
    denols = {
        settings = {
            deno = { enable = is_deno }
        },
        autostart = is_deno
    },
    gopls = {},
    eslint = {},
    gleam = {},
    html = {},
    lexical = {
        cmd = { vim.fn.expand("$HOME/.vpm/packages/lexical/_build/dev/package/lexical/bin/start_lexical.sh") }
    },
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" }
                }
            }
        }
    },
    pyright = {
        root_dir = lsp_util.root_pattern('.git', '.venv', 'requirements.txt', 'pyproject.toml') or vim.fn.getcwd()
    },
    rust_analyzer = {},
    templ = {},
    tsserver = {
        autostart = is_deno == false,
        single_file_support = is_deno == false,
    },
    ruff = {
        autostart = exe_exists(vim.fn.expand("$VIRTUAL_ENV/bin/black")) == false,
    },
}

local biome_cli = vim.fn.getcwd() .. "/node_modules/.bin/biome"
if is_deno == false and exe_exists(biome_cli) then
    lsp_settings["biome"] = { cmd = { biome_cli, "lsp-proxy" } }
end

local default_lsp_setup = {
    capabilities = capabilities,
}
for name, config in pairs(lsp_settings) do
    lspconfig[name].setup(vim.tbl_deep_extend("force", config, default_lsp_setup))
end

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

vim.diagnostic.config({ virtual_text = false })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
            return
        end
        if client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
        end

        local opts = { buffer = args.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
        -- replaced by conform
        -- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
    end,
})

local function hover_handler(handler, focusable)
    return function(err, result, ctx, config)
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        local is_pyright = client and client.name == 'pyright'
        if is_pyright and result then
            result.contents = vim.tbl_map(
                function(line)
                    line = string.gsub(line, '&nbsp;', ' ')
                    line = string.gsub(line, "&gt;", ">")
                    line = string.gsub(line, "&lt;", "<")
                    line = string.gsub(line, '\\', '')
                    line = string.gsub(line, '```python', '')
                    line = string.gsub(line, '```', '')
                    return line
                end,
                result.contents
            )
        end
        local bufnr, winnr = handler(
            err,
            result,
            ctx,
            vim.tbl_deep_extend('force', config or {}, {
                focusable = focusable,
                max_width = math.floor(vim.o.columns * 0.65),
            })
        )
        if not bufnr or not winnr then
            return
        end
        if is_pyright then
            vim.bo[bufnr].ft = 'text'
        end
        vim.wo[winnr].concealcursor = 'n'
        vim.wo[winnr].wrap = true
        vim.wo[winnr].linebreak = true
    end
end
vim.lsp.handlers['textDocument/hover'] = hover_handler(vim.lsp.handlers.hover, true)

-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
    }),
    sources = {
        { name = 'nvim_lsp' },
    },
    view = {
        docs = {
            auto_open = true
        },
        entries = "native"
    },
    matching = {
        disallow_fuzzy_matching = true,
        disallow_fullfuzzy_matching = true,
    },
    performance = {
        max_view_entries = 25,
    },
    preselect = cmp.PreselectMode.None,
}

-- conform setup
local conform = require("conform")
conform.setup({
    formatters_by_ft = {
        javascript = { "prettier", "biome" },
        typescript = { "prettier", "biome" },
        javascriptreact = { "prettier", "biome" },
        typescriptreact = { "prettier", "biome" },
        python = { "black" }
    },
    default_format_opts = {
        lsp_format = "fallback",
        stop_after_first = true,
        timeout_ms = 1000,
    }
})
vim.keymap.set('n', '<leader>f', function() conform.format() end)

-- treesitter setup
require('nvim-treesitter.configs').setup {
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
