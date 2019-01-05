function bakd
    set -l directory {$PWD}/.backup_files
    set -l timestamp
    set -l ls_cmd

    if test (uname) = "Darwin"
        set ls_cmd "/usr/local/bin/gls"
    else
        set ls_cmd "/bin/ls"
    end

    mkdir -p {$directory}

    for f in $argv
        set timestamp ( eval $ls_cmd --full-time {$f} | awk '{print $6"T"$7}' )
        mv {$f} {$directory}/{$f}.{$timestamp}; and cp -a {$directory}/{$f}.{$timestamp} {$f};
    end
end
