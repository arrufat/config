if status is-interactive
    # Jumping between prompts
    function mark_prompt_start --on-event fish_prompt
        echo -en "\e]133;A\e\\"
    end

    # Customize git prompt characters
    set -g __fish_git_prompt_char_dirtystate '±'
end

set -g -x EDITOR "kak"

# Idempotent: safe to re-source, unlike prepending to $PATH
fish_add_path -g $HOME/.local/bin

# Silence the greeting here rather than via `set -U`, so it travels with the repo
set -g fish_greeting
