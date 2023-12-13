
hook -group gnome-hooks global KakBegin .* %sh{
    if [ -n "$GNOME_TERMINAL_SERVICE" ] && [ -z "$TMUX" ]; then
        echo "require-module gnome"
    fi
}

provide-module gnome %{

declare-option -docstring %{window type that gnome-terminal creates on new and repl calls} str gnome_window_type gnome

define-command gnome-terminal -params 1.. -shell-completion -docstring '
gnome-terminal <program> [<arguments>]: create a new terminal as a gnome-terminal window
The program passed as argument will be executed in the new terminal' \
%{
    nop %sh{
        gnome-terminal --quiet --window --working-directory "$PWD" -- "$@"
    }
}

define-command gnome-terminal-tab -params 1.. -shell-completion -docstring '
gnome-terminal-tab <program> [<arguments>]: create a new terminal as gnome-terminal tab
The program passed as argument will be executed in the new terminal' \
%{
    nop %sh{
        gnome-terminal quiet --tab --active --working-directory "$PWD" -- "$@"
    }
}

define-command gnome-new-tab -params .. -shell-completion -docstring '
gnome-terminal-tab <program> [<arguments>]: create a new terminal as gnome-terminal tab
The program passed as argument will be executed in the new terminal' \
%{
    gnome-terminal-tab kak -c %val{session} -e "%arg{@}"
}

alias global terminal gnome-terminal
alias global terminal-tab gnome-terminal-tab
alias global new-tab gnome-new-tab

}
