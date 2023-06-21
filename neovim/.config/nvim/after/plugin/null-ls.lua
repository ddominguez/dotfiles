local null_ls = require("null-ls")

local function exepath_exists(s)
    local exepath = vim.fn.exepath(s)
    return exepath ~= nil and exepath ~= ""
end

local sources = {}

-- install black via Mason
table.insert(sources, null_ls.builtins.formatting.black)

if exepath_exists("flake8") then
    table.insert(sources, null_ls.builtins.diagnostics.flake8)
end

null_ls.setup({
    sources = sources
})
