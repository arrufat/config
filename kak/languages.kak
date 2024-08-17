evaluate-commands %sh{kak-lsp --kakoune -s $kak_session}
# set-option global lsp_cmd "kak-lsp -s %val{session} -vvv --log /tmp/kak-lsp.log"
hook global WinSetOption filetype=(c|cpp|css|go|html|javascript|latex|markdown|python|rust|typescript|zig) %{
    map window user -docstring 'LSP mode' l ': enter-user-mode lsp<ret>'
    lsp-enable-window
    lsp-auto-signature-help-enable
    lsp-auto-hover-insert-mode-disable
    set-option window lsp_hover_max_lines 20
    map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'
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
    set-option window formatcmd 'ruff format -'
    set-option window lintcmd 'ruff'
}

hook global WinSetOption filetype=zig %{
    set-option window formatcmd 'zig fmt --stdin'
    set-option window lintcmd 'zig fmt --color off --ast-check 2>&1'
    # set-option window makecmd 'zig build --summary all'
    set-option window lsp_auto_highlight_references true
    hook buffer -group format BufWritePre .* lsp-formatting-sync

    hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
    hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
    hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
    hook -once -always window WinSetOption filetype=.* %{
        remove-hooks window semantic-tokens
    }
    map window normal '<a-#>' ':exec %{x_i// autofix<lt>ret>if(false){<lt>esc>a<lt>ret>}<lt>esc>:format<lt>ret>_}<ret>'
    set-register pipe "fmt -w 99 -p '///'"
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

hook global WinSetOption filetype=go %{
    set-option window formatcmd 'gofmt'
    set-option window tabstop 4
    hook window -group format BufWritePre .* lsp-formatting-sync
    set-option window lsp_auto_highlight_references true
    set-option window lintcmd "run() { golint $1; go vet $1 2> | sed -e 's/: /: error /'; } && run"
    lint
    hook window -group lint BufWritePost *. lint
}

hook global WinSetOption filetype=html %{
    set-option window formatcmd "run(){ tidy -q --indent yes --indent-spaces %opt{tabstop} 2>/dev/null || true; } && run"
    set-option window lintcmd "tidy -e --gnu-emacs yes --quiet yes 2>&1"
}

hook global WinSetOption filetype=javascript %{
    set-option window formatcmd "prettier --stdin-filepath=%val{buffile}"
}

hook global WinSetOption filetype=makefile %{
    add-highlighter window/ show-whitespaces
}

