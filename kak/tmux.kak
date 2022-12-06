# Improved window management
# ──────────────────────────

declare-user-mode window
map global window -docstring 'select pane left' h %{: nop %sh{TMUX="${kak_client_env_TMUX}" tmux select-pane -L}<ret>}
map global window -docstring 'select pane down' j %{: nop %sh{TMUX="${kak_client_env_TMUX}" tmux select-pane -D}<ret>}
map global window -docstring 'select pane up' k %{: nop %sh{TMUX="${kak_client_env_TMUX}" tmux select-pane -U}<ret>}
map global window -docstring 'select pane right' l %{: nop %sh{TMUX="${kak_client_env_TMUX}" tmux select-pane -R}<ret>}
map global user -docstring 'window mode' w ': enter-user-mode window<ret>'

define-command new-right -docstring "create a new kakone client on the right" -params .. %{
    tmux-terminal-horizontal kak -c %val{session} -e "%arg{@}"}
alias global nr new-right
complete-command new-right -menu command
define-command new-below -docstring "create a new kakone client below" -params .. %{
    tmux-terminal-vertical kak -c %val{session} -e "%arg{@}"}
alias global nb new-below
complete-command new-below -menu command

# File managment with Broot
# ─────────────────────────

define-command broot-right -docstring "open broot right" -params .. %{
    tmux-terminal-horizontal "EDITOR=%opt{kak_open} KAK_SESSION=%val{session} KAK_CLIENT=%val{client} br %arg{@}"
}
alias global br broot-right
complete-command broot-right file

define-command broot-below -docstring "open broot below" -params .. %{
    tmux-terminal-vertical "EDITOR=%opt{kak_open} KAK_SESSION=%val{session} KAK_CLIENT=%val{client} br %arg{@}"
}
alias global bb broot-below
complete-command broot-below file

# IDE layout
# ──────────

define-command ide %{
    rename-client main
    nnn
    nop %sh{tmux swap-pane -s 0 -t 1}
    tmux-terminal-horizontal kak -c %val{session} -e "rename-client docs"
    tmux-focus main
    tmux-terminal-vertical kak -c %val{session} -e "rename-client tools"
    tmux-focus main
    set global docsclient docs
    set global toolsclient tools
    set global jumpclient main
    nop %sh{
        tmux resize-pane -t 0 -x 48
        tmux resize-pane -t 3 -x 80
        tmux resize-pane -t 2 -y 16
        tmux select-pane -t 0
    }
    lsp-auto-hover-disable
    lsp-auto-hover-enable docs
}
