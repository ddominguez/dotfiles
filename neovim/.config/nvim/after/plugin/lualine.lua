require("lualine").setup {
    options = {
        icons_enabled = false,
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_b = { "branch" },
        lualine_c = { "diff", "diagnostics", { "filename", path = 1 } }
    }
}
