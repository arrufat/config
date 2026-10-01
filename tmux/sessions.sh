#!/bin/sh
# Save and restore tmux sessions: windows, pane layouts, working directories
# and a few programs.
#
#   sessions.sh save             add a timestamped save, pointed to by "last"
#   sessions.sh restore [FILE]   recreate saved sessions that are not running

# Programs that are restarted with their arguments; anything else gets a shell
RESTORE="kak vim nvim less man tail btop htop top ssh"
# Number of saves to keep
KEEP=10

tab=$(printf '\t')
socket=$(basename "${TMUX%%,*}")
dir="${XDG_STATE_HOME:-$HOME/.local/state}/tmux/sessions-$socket"

# The program running in the foreground of a pane, if it is in $RESTORE
pane_command() {
    args=$(ps -o args= --ppid "$1" 2>/dev/null | head -n 1)
    prog=$(basename "${args%% *}")
    case " $RESTORE " in *" $prog "*) printf '%s' "$args" ;; esac
}

save() {
    mkdir -p "$dir"
    tmux list-panes -a -F "#{session_name}$tab#{window_index}$tab#{window_active}$tab#{window_layout}$tab#{window_width}$tab#{window_height}$tab#{pane_active}$tab#{pane_pid}$tab#{pane_current_path}" |
        while IFS="$tab" read -r s w wa layout width height pa pid path; do
            printf '%s\n' "$s$tab$w$tab$wa$tab$layout$tab$width$tab$height$tab$pa$tab$path$tab$(pane_command "$pid")"
        done >"$dir/tmp"
    # Skip empty saves and ones identical to the last
    if [ ! -s "$dir/tmp" ] || cmp -s "$dir/tmp" "$dir/last"; then
        rm -f "$dir/tmp"
        return
    fi
    file=$(date +%Y%m%dT%H%M%S)
    mv "$dir/tmp" "$dir/$file"
    ln -sfn "$file" "$dir/last"
    # Timestamps sort chronologically; drop all but the newest $KEEP
    ls "$dir" | grep -E '^[0-9]{8}T[0-9]{6}$' | head -n -"$KEEP" | while read -r old; do
        rm -f "$dir/$old"
    done
}

restore() {
    file=${1:-$dir/last}
    [ -r "$file" ] || { tmux display "No saved sessions in $file"; exit 1; }
    todo=$(mktemp)
    last_s="" last_w="" skip=0
    while IFS="$tab" read -r s w wa layout width height pa path cmd; do
        if [ "$s" != "$last_s" ]; then
            last_s=$s last_w=$w
            if tmux has-session -t "=$s" 2>/dev/null; then skip=1; continue; fi
            skip=0
            ids=$(tmux new-session -d -P -F '#{window_id} #{pane_id}' -s "$s" -c "$path" -x "$width" -y "$height")
            wid=${ids% *} pane=${ids#* }
            tmux move-window -s "$wid" -t "=$s:$w" 2>/dev/null
        elif [ "$skip" = 1 ]; then
            continue
        elif [ "$w" != "$last_w" ]; then
            last_w=$w
            ids=$(tmux new-window -d -P -F '#{window_id} #{pane_id}' -t "=$s:$w" -c "$path")
            wid=${ids% *} pane=${ids#* }
        else
            # Split after the previous pane to keep the saved order; retile so
            # there is always room for the next split
            pane=$(tmux split-window -d -P -F '#{pane_id}' -t "$pane" -c "$path")
            tmux select-layout -t "$wid" tiled
        fi
        [ "$pa" = 1 ] && echo "select-pane -t $pane" >>"$todo"
        [ "$wa" = 1 ] && [ "$pa" = 1 ] && echo "select-window -t $wid" >>"$todo"
        echo "select-layout -t $wid $layout" >>"$todo"
        [ -n "$cmd" ] && tmux send-keys -t "$pane" -l "$cmd" && tmux send-keys -t "$pane" Enter
    done <"$file"
    # Layouts last, once every pane of each window exists
    while read -r line; do tmux $line; done <"$todo"
    rm -f "$todo"
    tmux display "Sessions restored"
}

case $1 in
    save) save ;;
    restore) restore "$2" ;;
    *) echo "usage: $0 save|restore [FILE]" >&2; exit 2 ;;
esac
