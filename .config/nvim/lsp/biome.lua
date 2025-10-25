local biome_cli = vim.fn.getcwd() .. "/node_modules/.bin/biome"

return {
    cmd = { biome_cli, 'lsp-proxy' },
    root_markers = { 'biome.json', 'biome.jsonc' },
    filetypes = {
        'astro',
        'css',
        'graphql',
        'javascript',
        'javascriptreact',
        'json',
        'jsonc',
        'svelte',
        'typescript',
        'typescript.tsx',
        'typescriptreact',
        'vue',
    },
}
