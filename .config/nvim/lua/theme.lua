local function is_kitty_light_theme()
    local theme_file = vim.fn.expand("~/.config/kitty/theme.conf")
    local handle = io.open(theme_file, "r")
    if not handle then return false end
    local first_line = handle:read("*l")
    handle:close()
    return first_line and first_line:find("light theme") ~= nil
end

local is_light = is_kitty_light_theme()

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
    vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. level, vim.tbl_extend("force",
        vim.api.nvim_get_hl(0, { name = "DiagnosticUnderline" .. level }),
        { cterm = { undercurl = true }, undercurl = true }
    ))
end

if is_light then
    vim.api.nvim_set_hl(0, "Normal", { ctermfg = 0 })
    vim.api.nvim_set_hl(0, "Comment", { ctermfg = 7 })
    vim.api.nvim_set_hl(0, "FloatBorder", { ctermfg = 12 })
    vim.api.nvim_set_hl(0, "PmenuThumb", { ctermbg = 12 })
    vim.api.nvim_set_hl(0, "Statement", { ctermfg = 5, bold = true })
    vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 7 })
    vim.api.nvim_set_hl(0, "String", { ctermfg = 4 })
    vim.api.nvim_set_hl(0, "Search", { ctermfg = 0, ctermbg = 10 })
    vim.api.nvim_set_hl(0, "CurSearch", { ctermfg = 0, ctermbg = 10 })
    vim.api.nvim_set_hl(0, "Error", { ctermfg = 1, bold = true })
else
    vim.api.nvim_set_hl(0, "Normal", { ctermfg = 7 })
    vim.api.nvim_set_hl(0, "Comment", { ctermfg = 8 })
    vim.api.nvim_set_hl(0, "FloatBorder", { ctermfg = 12 })
    vim.api.nvim_set_hl(0, "Pmenu", { ctermbg = 0 })
    vim.api.nvim_set_hl(0, "PmenuThumb", { ctermbg = 12 })
    vim.api.nvim_set_hl(0, "Statement", { ctermfg = 5, bold = false })
    vim.api.nvim_set_hl(0, "PreProc", { bold = false })
    vim.api.nvim_set_hl(0, "Conceal", { ctermfg = 7 })
    vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 0 })
end
