evaluate-commands %sh{kak-lsp}
# set-option global lsp_cmd "kak-lsp -s %val{session} -vvv --log /tmp/kak-lsp.log"
hook global WinSetOption filetype=(c|cpp|css|go|html|javascript|latex|markdown|python|rust|typescript|zig) %{
    map window user -docstring 'LSP mode' l ': enter-user-mode lsp<ret>'
    set-option global lsp_snippet_support false
    lsp-enable-window
    lsp-auto-signature-help-enable
    lsp-auto-hover-insert-mode-disable
    set-option window lsp_auto_highlight_references true
    set-option window lsp_hover_max_lines 20
}

# Semantic highlighting for supported languages
hook global WinSetOption filetype=(c|cpp|html|javascript|typescript|go|rust|zig) %{
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

hook -group lsp-filetype-c-family global BufSetOption filetype=(?:c|cpp|objc) %{
    set-option buffer lsp_servers %{
        [clangd]
        root_globs = ["compile_commands.json", ".clangd", ".git", ".hg"]
        args = ["-clang-tidy", "-compile-commands-dir=build", "-background-index", "-completion-style=detailed", "-header-insertion=never",  "--malloc-trim"]
    }
}

hook global WinSetOption filetype=python %{
    set-option window formatcmd 'ruff format -'
    set-option window lintcmd 'ruff'
}

hook -group lsp-filetype-python global BufSetOption filetype=python %{
    set-option buffer lsp_servers %{
        [jedi-language-server]
        root_globs = ["requirements.txt", "setup.py", "pyproject.toml", ".git", ".hg"]
    }
    set-option -add buffer lsp_servers %{
        [ruff]
        args = ["server", "--quiet"]
        root_globs = ["requirements.txt", "setup.py", "pyproject.toml", ".git", ".hg"]
        settings_section = "_"
        [ruff.settings._.globalSettings]
        organizeImports = true
        fixAll = true
    }
}

hook global WinSetOption filetype=zig %{
    # remove-highlighter window/zig
    set-option window formatcmd 'zig fmt --stdin'
    set-option window lintcmd 'zig fmt --color off --ast-check 2>&1'
    set-option window makecmd 'zig build --summary all'
    hook window -group format BufWritePre .* lsp-formatting-sync
    map window normal '<a-#>' ':exec %{x_i// autofix<lt>ret>if(false){<lt>esc>a<lt>ret>}<lt>esc>:format<lt>ret>_}<ret>'
    set-register pipe "fmt -w 99 -p '///'"
}

hook global WinSetOption filetype=rust %{
    set-option window formatcmd 'rustfmt'
    hook window -group format BufWritePre .* lsp-formatting-sync
}

hook global WinSetOption filetype=go %{
    set-option window formatcmd 'gofmt'
    set-option window tabstop 4
    hook window -group format BufWritePre .* lsp-formatting-sync
    set-option window lsp_auto_highlight_references true
    set-option window lintcmd "run() { golint $1; go vet $1 2> | sed -e 's/: /: error /'; } && run"
    lint
}

hook global BufSetOption filetype=go %{
    set-option buffer lsp_servers %{
        [gopls]
        root_globs = ["Gopkg.toml" "go.mod" ".git" ".hg"]
        [gopls.settings.gopls]
        hints.assignVariableTypes = true
        hints.compositeLiteralFields = true
        hints.compositeLiteralTypes = true
        hints.constantValues = true
        hints.functionTypeParameters = true
        hints.parameterNames = true
        hints.rangeVariableTypes = true
        usePlaceholders = true
        semanticTokens = true
    }
}

hook global WinSetOption filetype=html %{
    set-option window formatcmd 'superhtml fmt --stdin'
    # set-option window lintcmd "run() { superhtml check $1 } && run"
    set-option window lintcmd 'superhtml check'
    hook buffer -group format BufWritePre .* lsp-formatting-sync
}

hook -group lsp-filetype-html global BufSetOption filetype=html %{
    set-option buffer lsp_servers %{
        [vscode-html-language-server]
        root_globs = ["package.json"]
        args = ["--stdio"]
        settings_section = "_"
        [vscode-html-language-server.settings._]
        quotePreference = "single"
        javascript.format.semicolons = "insert"
    }
    set-option -add buffer lsp_servers %{
        [superhtml]
        root_globs = ["index.html", "package.json"]
        args = ["lsp"]
    }
}

hook global WinSetOption filetype=javascript %{
    set-option window formatcmd "prettier --stdin-filepath=%val{buffile}"
}

hook -group lsp-filetype-javascript global BufSetOption filetype=(?:javascript|typescript) %{
    set-option buffer lsp_servers %{
        [typescript-language-server]
        root_globs = ["package.json", "tsconfig.json", "jsconfig.json", ".git", ".hg"]
        args = ["--stdio"]
        settings_section = "_"
        [typescript-language-server.settings._]
        quotePreference = "double"
        typescript.format.semicolons = "insert"
    }
    # set-option -add buffer lsp_servers %{
    #     [biome]
    #     root_globs = ["biome.json", "package.json", "tsconfig.json", "jsconfig.json", ".git", ".hg"]
    #     args = ["lsp-proxy"]
    # }
    set-option -add buffer lsp_servers %{
        [eslint-language-server]
        root_globs = [".eslintrc", ".eslintrc.json"]
        args = ["--stdio"]
        workaround_eslint = true
        [eslint-language-server.settings]
        codeActionsOnSave = { mode = "all", "source.fixAll.eslint" = true }
        format = { enable = true }
        quiet = false
        rulesCustomizations = []
        run = "onType"
        validate = "on"
        experimental = {}
        problems = { shortenToSingleLine = false }
        codeAction.disableRuleComment = { enable = true, location = "separateLine" }
        codeAction.showDocumentation = { enable = false }
    }
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
