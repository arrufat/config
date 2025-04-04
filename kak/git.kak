hook global WinSetOption filetype=git-commit %{
    declare-option -hidden range-specs commit_column_ranges
    add-highlighter window/ ranges commit_column_ranges
    define-command update_commit_column_ranges %{
        set-option window commit_column_ranges %val{timestamp}
        set-option -add window commit_column_ranges '1.51,1.51|,yellow'
        set-option -add window commit_column_ranges '3.73,3.73|,yellow'
    }
    hook -always global NormalIdle '' update_commit_column_ranges
    hook -always global InsertIdle '' update_commit_column_ranges
    hook -always global PromptIdle '' update_commit_column_ranges
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

hook global WinSetOption filetype=git-status %{
    map global git -docstring 'add file' a %{<a-i><a-w>:git add %reg{dot}<ret>:git status<ret>}
    map global git -docstring 'reset file' r %{<a-i><a-w>:git reset %reg{dot}<ret>: git status<ret>}
    hook -once -always window WinSetOption filetype=.* %{
        unmap global git a
        unmap global git r
    }
}

define-command tig -params .. -docstring "Run tig" %{
    terminal env "EDITOR=kak -c %val{session}" tig %arg{@}
}
