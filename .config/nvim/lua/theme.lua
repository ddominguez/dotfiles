local function is_kitty_light_theme()
    if vim.env.TERM ~= "xterm-kitty" then
        return false
    end
    local theme_file = vim.fn.expand("~/.config/kitty/theme.conf")
    local handle = io.open(theme_file, "r")
    if not handle then return false end
    local first_line = handle:read("*l")
    handle:close()
    return first_line and first_line:find("light theme") ~= nil
end

local is_light_theme = is_kitty_light_theme()

vim.opt.termguicolors = false
vim.cmd("colorscheme default")

vim.api.nvim_set_hl(0, "SignColumn", {})
vim.api.nvim_set_hl(0, "MatchParen", {})
vim.api.nvim_set_hl(0, "NormalFloat", {})
vim.api.nvim_set_hl(0, "LspReferenceTarget", {})
vim.api.nvim_set_hl(0, "StatusLineNC", { cterm = { underline = true } })


-- when do we see the Ok level??
-- and should it also have the undercurl??
local DiagnosticLevels = { "Error", "Warn", "Info", "Hint" }
for _, level in pairs(DiagnosticLevels) do
    vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. level, {
        update = true, undercurl = true
    })
end

-- TODO: Try getting specific colors from kitty
-- kitten @ get-colors | grep "^color1 " | tr -s " " | cut -d" " -f2

if is_light_theme then
    vim.api.nvim_set_hl(0, "Normal", { ctermfg = 0 })
    vim.api.nvim_set_hl(0, "Comment", { ctermfg = 15 })
    vim.api.nvim_set_hl(0, "Pmenu", { reverse = true })
    vim.api.nvim_set_hl(0, "PmenuThumb", { ctermbg = 12 })
    vim.api.nvim_set_hl(0, "Statement", { ctermfg = 5, bold = true })
    vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 103 })
    vim.api.nvim_set_hl(0, "String", { ctermfg = 4 })
    vim.api.nvim_set_hl(0, "Special", { ctermfg = 0 })
    vim.api.nvim_set_hl(0, "Function", { ctermfg = 0 })
    vim.api.nvim_set_hl(0, "Operator", { ctermfg = 5, bold=true })
    vim.api.nvim_set_hl(0, "Search", { ctermfg = 0, ctermbg = 10 })
    vim.api.nvim_set_hl(0, "CurSearch", { ctermfg = 0, ctermbg = 10 })
    vim.api.nvim_set_hl(0, "Error", { ctermfg = 1, bold = true })
    vim.api.nvim_set_hl(0, "StatusLine", { ctermbg = 103, ctermfg = 0, bold = true })
    vim.api.nvim_set_hl(0, "StatusLineNC", { ctermbg = 103, ctermfg = 8 })
else
    vim.api.nvim_set_hl(0, "Normal", { ctermfg = 7 })
    vim.api.nvim_set_hl(0, "Comment", { ctermfg = 8 })
    vim.api.nvim_set_hl(0, "FloatBorder", { ctermfg = 12 })
    vim.api.nvim_set_hl(0, "Pmenu", { ctermbg = 0 })
    vim.api.nvim_set_hl(0, "PmenuThumb", { ctermbg = 12 })
    vim.api.nvim_set_hl(0, "Statement", { ctermfg = 5, bold = false })
    vim.api.nvim_set_hl(0, "PreProc", { bold = false })
    vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 0 })
    vim.api.nvim_set_hl(0, "StatusLine", { ctermbg = 0, ctermfg = 7, bold = true })
    vim.api.nvim_set_hl(0, "StatusLineNC", { ctermbg = 0, ctermfg = 8 })
end
