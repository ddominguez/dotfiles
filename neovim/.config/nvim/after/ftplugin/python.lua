local uv_lockfile = vim.fn.getcwd() .. "/uv.lock"

local cmd
if vim.loop.fs_stat(uv_lockfile) then
    cmd = "uv run %<CR>"
else
    cmd = "python %<CR>"
end

vim.keymap.set("n", "<leader>x", ":bel term " .. cmd, { buffer = true })
vim.treesitter.start()
