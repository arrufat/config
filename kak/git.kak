declare-user-mode git
map global git -docstring 'edit' e ':git edit '
map global git -docstring 'status' s ':git status<ret>'
map global git -docstring 'commit' c ':git commit<ret>'
map global git -docstring 'update diff' u ':git update-diff<ret>'
map global git -docstring 'show diff' d ':git show-diff<ret>'
map global git -docstring 'hide diff' <a-d> ':git hide-diff<ret>'
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
