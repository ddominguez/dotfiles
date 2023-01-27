local null_ls = require("null-ls")

local function isempty(s)
  return s == nil or s == ""
end

local sources = {}

if not isempty(vim.fn.exepath("black")) then
    table.insert(sources, null_ls.builtins.formatting.black)
end

if not isempty(vim.fn.exepath("flake8")) then
    table.insert(sources, null_ls.builtins.diagnostics.flake8)
end

null_ls.setup({
    sources=sources
})
