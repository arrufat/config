if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g -x EDITOR "kak"

# only meant to be used from kakrc
set -g -x NNN_PLUG ";:kak_open"
# nnn nord theme
set -g -x BLK "0B"
set -g -x CHR "0B"
set -g -x DIR "04"
set -g -x EXE "06"
set -g -x REG "00"
set -g -x HARDLINK "06"
set -g -x SYMLINK "06"
set -g -x MISSING "00"
set -g -x ORPHAN "09"
set -g -x FIFO "06"
set -g -x SOCK "0B"
set -g -x OTHER "06"
set -g -x NNN_FCOLORS "$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Jumping between prompts
function mark_prompt_start --on-event fish_prompt
    echo -en "\e]133;A\e\\"
end

# Customize git prompt characters
set -g __fish_git_prompt_char_dirtystate '±'
