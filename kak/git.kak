declare-option -hidden range-specs commit_column_ranges
define-command -hidden update_commit_column_ranges %{
    set-option window commit_column_ranges %val{timestamp} '1.51,1.51|,yellow'
}
hook global WinSetOption filetype=git-commit %{
    add-highlighter window/commit-columns ranges commit_column_ranges
    add-highlighter window/commit-body-limit regex '^[^#\n][^\n]{71}\K[^\n]' 0:,yellow
    hook -group commit-columns window NormalIdle '' update_commit_column_ranges
    hook -group commit-columns window InsertIdle '' update_commit_column_ranges
}


declare-user-mode git
map global git -docstring 'edit' e ':git edit '
map global git -docstring 'diff' d ':git diff %val{bufname}<ret>'
map global git -docstring 'status' s ':git status<ret>'
map global git -docstring 'commit' c ':git commit<ret>'
map global git -docstring 'update diff' u ':git update-diff<ret>'
map global git -docstring 'git gutter on' g ':git show-diff<ret>'
map global git -docstring 'git gutter off' <a-g> ':git hide-diff<ret>'
map global git -docstring 'toggle blame' b ':git blame<ret>'
map global git -docstring 'next hunk' n ':git next-hunk<ret>'
map global git -docstring 'prev hunk' p ':git prev-hunk<ret>'

map global user -docstring 'git mode' g ':enter-user-mode git<ret>'

define-command -hidden git-status-restore-position %{
    evaluate-commands -save-regs '/' %{
        set-register / "\Q%reg{e}\E"
        try %{ execute-keys 'ggn<a-;>;' }
    }
}
define-command -hidden git-status-run -docstring 'run a git command on the file under the cursor' -params 1 %{
    evaluate-commands -draft %{
        execute-keys '<a-i><a-w>'
        set-register e "%reg{dot}"
        git %arg{1} %reg{dot}
    }
    git status
    hook -once -always global BufCloseFifo .* "evaluate-commands -client %val{client} git-status-restore-position"
}
hook global WinSetOption filetype=git-status %{
    map window git -docstring 'add file' a ':git-status-run add<ret>'
    map window git -docstring 'reset file' r ':git-status-run reset<ret>'
}

define-command tig -params .. -docstring "Run tig" %{
    terminal env "EDITOR=kak -c %val{session}" tig %arg{@}
}
