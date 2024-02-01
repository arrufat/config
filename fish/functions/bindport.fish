function bindport
    # SSH into a remote host, while binding a port
    set -l options h/help 'l/local=' 'r/remote=' 'p/port='
    argparse $options -- $argv
    or return

    if set -q _flag_help
        echo "bindport HOST [-h|--help] [-r|--remote=9000] [-l|--local=9000] [-p|--port=22]"
        return 0
    end

    set -l host $argv[1]
    set -l custom_port 22
    set -l remote_port 9000
    set -l local_port $remote_port

    if test -n "$_flag_port"
        set custom_port $_flag_port
    end

    if test -n "$_flag_remote"
        set remote_port $_flag_remote
    end

    if test -n "$_flag_local"
        set local_port $_flag_local
    end

    echo "Connecting to $argv[1]:$custom_port and binding remote port $remote_port to $local_port."

    ssh -L $local_port:127.0.0.1:$remote_port -L $remote_port:127.0.0.1:$remote_port -p $custom_port $host
end
