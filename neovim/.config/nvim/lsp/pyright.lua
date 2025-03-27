return {
    cmd = { 'pyright-langserver', '--stdio' },
    root_markers = { 'pyproject.toml', 'requirements.txt', 'setup.py', 'setup.cfg' },
    filetypes = { 'python' },
    settings = {
        python = {
            analysis = {
                autoSearchPath = true,
                diagnosticMode = 'opensFilesOnly',
                useLibraryCodeForTypes = true,
            }
        }
    },
}
