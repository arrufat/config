evaluate-commands %sh{kak-lsp --kakoune -s $kak_session}
# set-option global lsp_cmd "kak-lsp -s %val{session} -vvv --log /tmp/kak-lsp.log"
hook global WinSetOption filetype=(c|cpp|css|go|html|javascript|latex|markdown|python|rust|typescript|zig) %{
    map window user -docstring 'LSP mode' l ': enter-user-mode lsp<ret>'
    lsp-enable-window
    lsp-auto-signature-help-enable
    lsp-auto-hover-insert-mode-disable
    set-option window lsp_auto_highlight_references true
    set-option window lsp_hover_max_lines 20
    map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'
}

# Semantic highlighting for supported languages
hook global WinSetOption filetype=(c|cpp|go|rust|zig) %{
    hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
    hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
    hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
    hook -once -always window WinSetOption filetype=.* %{
        remove-hooks window semantic-tokens
    }
}

hook global WinSetOption filetype=(c|cpp) %{
    set-option window formatcmd 'clang-format'
}

hook global WinSetOption filetype=python %{
    set-option window formatcmd 'ruff format -'
    set-option window lintcmd 'ruff'
}

hook global WinSetOption filetype=zig %{
    set-option window formatcmd 'zig fmt --stdin'
    set-option window lintcmd 'zig fmt --color off --ast-check 2>&1'
    # set-option window makecmd 'zig build --summary all'
    hook buffer -group format BufWritePre .* lsp-formatting-sync
    map window normal '<a-#>' ':exec %{x_i// autofix<lt>ret>if(false){<lt>esc>a<lt>ret>}<lt>esc>:format<lt>ret>_}<ret>'
    set-register pipe "fmt -w 99 -p '///'"
}

hook global WinSetOption filetype=rust %{
    set-option window formatcmd 'rustfmt'
}

hook global WinSetOption filetype=go %{
    set-option window formatcmd 'gofmt'
    set-option window tabstop 4
    hook window -group format BufWritePre .* lsp-formatting-sync
    set-option window lsp_auto_highlight_references true
    set-option window lintcmd "run() { golint $1; go vet $1 2> | sed -e 's/: /: error /'; } && run"
    lint
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

set-option global lsp_semantic_tokens %{
    [
        # values
        {token = "number", face = "value"},
        {token = "enumMember", face = "value"},
        {token = "enumMember", modifiers = ["declaration"], face = "value_declaration"},
        {token = "keywordLiteral", face = "value"},

        # types
        {token = "type", face = "type"},
        {token = "class", face = "type"},
        {token = "enum", face = "type"},
        {token = "struct", face = "type"},
        {token = "type", modifiers = ["declaration"], face = "type_declaration"},
        {token = "class", modifiers = ["declaration"], face = "type_declaration"},
        {token = "enum", modifiers = ["declaration"], face = "type_declaration"},
        {token = "struct", modifiers = ["declaration"], face = "type_declaration"},
        {token = "typeParameter", face = "type_declaration"},

        # variables
        {token = "variable", face = "variable"},
        {token = "variable", modifiers = ["declaration"], face = "variable_declaration"},
        {token = "parameter", modifiers = ["declaration"], face = "variable_declaration"},
        {token = "property", face = "property"},
        {token = "property", modifiers = ["declaration"], face = "property_declaration"},

        # modules
        {token = "namespace", face = "module"},

        # functions
        {token = "function", face = "function"},
        {token = "function", modifiers = ["declaration"], face = "function_declaration"},
        {token = "method", face = "method"},
        {token = "method", modifiers = ["declaration"], face = "method_declaration"},

        # strings
        # {token = "string", face = "string"},

        # keywords
        {token = "keyword", face = "keyword"},

        # operator
        {token = "operator", face = "operator"},

        # attributes
        {token = "attribute", face = "attribute"},

        # comments
        {token = "comment", face = "comment"},
        {token = "comment", modifiers = ["documentation"], face = "documentation"},

        # meta
        {token = "macro", face = "meta"},
        {token = "dependent", face = "meta_member"},

        # builtins
        {token = "builtin", face = "builtin"},

        # other
        {token = "concept", face = "concept"},
        {token = "regexp", face = "regexp"},
        {token = "label", face = "label"},
        {token = "errorTag", face = "errortag"},
    ]
}
