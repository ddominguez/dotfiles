vim.g.html_no_rendering = 1

-- html
vim.api.nvim_set_hl(0, "@tag", { ctermfg = 5 })
vim.api.nvim_set_hl(0, "@tag.delimiter", { ctermfg = 12 })
vim.api.nvim_set_hl(0, "@tag.attribute", { ctermfg = 7 })
vim.api.nvim_set_hl(0, "@markup.heading", { ctermfg = 7, bold = true })

-- css
vim.cmd("runtime! ftplugin/css.lua")
