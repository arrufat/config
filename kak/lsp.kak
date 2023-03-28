evaluate-commands %sh{kak-lsp --kakoune -s $kak_session}
hook global WinSetOption filetype=(c|cpp|cmake|go|julia|latex|python|rust|sh|vala|zig) %{
    map window user -docstring 'LSP mode' l ': enter-user-mode lsp<ret>'
    lsp-enable-window
    lsp-auto-signature-help-enable
    lsp-auto-hover-insert-mode-disable
    set-option global lsp_hover_max_lines 20
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
    set-option window formatcmd 'black -l 78 -q -'
    set-option window lintcmd 'flake8'
    set-option global lsp_server_configuration pylsp.configurationSources=["flake8"]
    set-option -add global lsp_server_configuration pylsp.plugins.pycodestyle.ignore=["E203,W503"]
    set-option -add global lsp_server_configuration pylsp.plugins.pycodestyle.maxLineLength=78
}

hook global WinSetOption filetype=rust %{
    set-option window formatcmd 'rustfmt'
    set-option window lsp_auto_highlight_references true
    set-option global lsp_hover_max_lines 20
    hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
    hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
    hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
    hook -once -always window WinSetOption filetype=.* %{
        remove-hooks window semantic-tokens
    }
}

hook global WinSetOption filetype=zig %{
    set-option buffer formatcmd 'zig fmt'
    set-option window lsp_auto_highlight_references true
    hook buffer -group format BufWritePre .* lsp-formatting-sync

    set-option global lsp_server_configuration zls.zig_lib_path="/usr/lib/zig"
    set-option -add global lsp_server_configuration zls.warn_style=true
    set-option -add global lsp_server_configuration zls.enable_semantic_tokens=true
    set-option -add global lsp_server_configuration zls.operator_completions=true
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
