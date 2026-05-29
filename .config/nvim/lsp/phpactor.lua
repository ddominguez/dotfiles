return {
    cmd = { 'phpactor', 'language-server' },
    filetypes = { 'php' },
    root_markers = { '.git', 'composer.json', '.phpactor.json', '.phpactor.yml' },
    workspace_required = true,
    init_options = {
        ["language_server_phpstan.enabled"] = false,
        ["language_server_psalm.enabled"] = false,
        -- ["language_server.diagnostics_on_update"] = false,
        ["language_server_highlight.enabled"] = false,
    }
}
