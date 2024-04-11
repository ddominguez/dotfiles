-- gitsigns setup
require("gitsigns").setup()

-- lsp and autocomplete setup
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require('lspconfig')
local lsp_util = require('lspconfig.util')

local is_deno_proj = function()
    if lsp_util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
        return true
    end
    return false
end

local lsp_settings = {
    cssls = {},
    denols = {
        settings = {
            deno = { enable = is_deno_proj() }
        },
        autostart = is_deno_proj()
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
    pyright = {},
    rust_analyzer = {},
    templ = {},
    tsserver = {
        autostart = is_deno_proj() == false,
        single_file_support = is_deno_proj() == false,
    }
}
for k, v in pairs(lsp_settings) do
    local c = v
    c.capabilities = capabilities
    lspconfig[k].setup(c)
end

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

vim.diagnostic.config({ virtual_text = false })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
        -- replaced by conform
        -- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
    end,
})

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
            select = true,
        },
    }),
    sources = {
        { name = 'nvim_lsp' },
    },
    view = {
        docs = {
            auto_open = false
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
}

-- conform setup
local conform = require("conform")
conform.setup({
    formatters_by_ft = {
        javascript = { { "biome", "prettier" } },
        typescript = { { "biome", "prettier" } },
        javascriptreact = { { "biome", "prettier" } },
        typescriptreact = { { "biome", "prettier" } },
        python = { { "ruff_format", "black" } }
    }
})
vim.keymap.set('n', '<leader>f', function()
    conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    })
end)

-- treesitter setup
require('nvim-treesitter.configs').setup {
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
