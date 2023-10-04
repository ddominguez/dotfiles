local builtin = require("telescope.builtin")

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

local telescope = require("telescope")
telescope.setup({
    defaults = {
        file_ignore_patterns = {
            ".venv/",
            ".git/",
            "__pycache__/",
            "node_modules/",
        }
    },
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "--hidden" }
        },
        live_grep = {
            glob_pattern = { "!package-lock.json" }
        }
    }
})
