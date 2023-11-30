if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -g -x NNN_PLUG ";:kak_open"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
