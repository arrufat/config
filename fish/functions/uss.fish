function uss
    # List processes by USS (unique/private memory), merged by executable.
    #
    # USS is the memory unique to a process: what would be freed if it exited.
    # It is the metric gnome-system-monitor's "Memory" column shows (resident
    # minus shared), unlike btop/htop/resources which show RSS, or at best PSS.
    # USS = Private_Clean + Private_Dirty, read from /proc/PID/smaps_rollup.
    #
    # On a merged row prefer PSS: summing USS undercounts, because pages shared
    # between those processes belong to no single process's USS, whereas
    # summing PSS counts them exactly once.
    #
    # Processes owned by other users are skipped unless run as root.
    set -l options h/help d/detail
    argparse $options -- $argv
    or return

    if set -q _flag_help
        echo "uss [-h|--help] [-d|--detail] [COUNT]"
        return 0
    end

    set -l n 15
    if set -q argv[1]
        if not string match -qr '^[0-9]+$' -- $argv[1]
            echo "uss: count must be a positive integer" >&2
            return 1
        end
        set n $argv[1]
    end

    if set -q _flag_detail
        printf '%8s %10s %10s %10s  %s\n' PID USS PSS RSS COMMAND
    else
        printf '%8s %10s %10s %10s  %s\n' N USS PSS RSS COMMAND
    end

    begin
        if set -q _flag_detail
            __uss_collect
        else
            __uss_collect | awk -F\t '
                { u[$5] += $1; p[$5] += $2; r[$5] += $3; c[$5]++ }
                END { for (k in u) printf "%d\t%d\t%d\t%d\t%s\n", u[k], p[k], r[k], c[k], k }
            '
        end
    end | sort -t\t -k1,1rn | head -n $n |
        awk -F\t '{ printf "%8s %9.1fM %9.1fM %9.1fM  %s\n", $4, $1/1024, $2/1024, $3/1024, $5 }'
end

function __uss_collect
    # One tab-separated record per process: uss, pss, rss, pid, name.
    # name can contain spaces, so it stays last and tabs are the delimiter.
    for d in /proc/*
        string match -qr '^/proc/[0-9]+$' -- $d
        or continue
        test -r $d/smaps_rollup
        or continue
        # Group on the executable, not comm: the kernel truncates comm to 15
        # chars, which mangles long names ("Isolated Web Co") and can merge
        # unrelated programs sharing a prefix. Fall back to comm when exe is
        # unreadable, e.g. kernel threads.
        set -l name (readlink $d/exe 2>/dev/null | string replace -r ' \\(deleted\\)$' '' | string replace -r '^.*/' '')
        if test -z "$name"
            set name (tr -d '\0\t' <$d/comm 2>/dev/null)
        end
        test -n "$name"
        or continue
        awk -v pid=(string replace /proc/ '' -- $d) -v name="$name" '
            /^Private_Clean:/ { u += $2 }
            /^Private_Dirty:/ { u += $2 }
            /^Pss:/           { p  = $2 }
            /^Rss:/           { r  = $2 }
            END { if (u > 0) printf "%d\t%d\t%d\t%s\t%s\n", u, p, r, pid, name }
        ' $d/smaps_rollup 2>/dev/null
    end
end
