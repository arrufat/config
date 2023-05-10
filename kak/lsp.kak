evaluate-commands %sh{kak-lsp --kakoune -s $kak_session}
hook global WinSetOption filetype=(c|cpp|cmake|go|julia|latex|python|rust|sh|vala|zig) %{
    map window user -docstring 'LSP mode' l ': enter-user-mode lsp<ret>'
    lsp-enable-window
    lsp-auto-signature-help-enable
    lsp-auto-hover-insert-mode-disable
    set-option window lsp_hover_max_lines 20
}

hook global WinSetOption filetype=(c|cpp) %{
    set-option window formatcmd 'clang-format'
    set-option window lsp_auto_highlight_references true
    hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
    hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
    hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
    hook -once -always window WinSetOption filetype=.* %{
        remove-hooks window semantic-tokens
    }
}

hook global WinSetOption filetype=python %{
    set-option window formatcmd 'black -l 99 -q -'
    set-option window lintcmd 'ruff'
    set-option -add window lsp_server_configuration pylsp.plugins.black.enabled=true
    set-option -add window lsp_server_configuration pylsp.plugins.black.line_length=99
    set-option -add window lsp_server_configuration pylsp.configurationSources=["ruff"]
    set-option -add window lsp_server_configuration pylsp.plugins.pycodestyle.enabled=false
    set-option -add window lsp_server_configuration pylsp.plugins.mccabe.enabled=false
    set-option -add window lsp_server_configuration pylsp.plugins.pyflakes.enabled=false
    set-option -add window lsp_server_configuration pylsp.plugins.ruff.enabled=true
    set-option -add window lsp_server_configuration pylsp.plugins.ruff.ignore=["E402"]
    set-option -add window lsp_server_configuration pylsp.plugins.ruff.lineLength=99
}

hook global WinSetOption filetype=rust %{
    set-option window formatcmd 'rustfmt'
    set-option window lsp_auto_highlight_references true
    hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
    hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
    hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
    hook -once -always window WinSetOption filetype=.* %{
        remove-hooks window semantic-tokens
    }
}

hook global WinSetOption filetype=zig %{
    set-option window formatcmd 'zig fmt --stdin'
    set-option window lsp_auto_highlight_references true
    hook buffer -group format BufWritePre .* lsp-formatting-sync

    set-option window lsp_server_configuration zls.zig_lib_path="/usr/lib/zig"
    set-option -add window lsp_server_configuration zls.warn_style=true
    set-option -add window lsp_server_configuration zls.enable_semantic_tokens=true
    set-option -add window lsp_server_configuration zls.operator_completions=true
    hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
    hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
    hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
    hook -once -always window WinSetOption filetype=.* %{
        remove-hooks window semantic-tokens
    }
}

hook global WinSetOption filetype=go %{
    set-option buffer formatcmd 'go fmt'
    hook buffer -group format BufWritePre .* lsp-formatting-sync
    set-option buffer lsp_auto_highlight_references true
    set-option buffer lintcmd "run() { golint $1; go vet $1 2> | sed -e 's/: /: error /'; } && run"
    lint
    hook buffer -group lint BufWritePost *. lint
}

hook global WinSetOption filetype=cmake %{
    set-option window formatcmd 'cmake-format-i -'
    lsp-auto-hover-disable
    hook buffer -group lint BufWritePost *. lint
}

