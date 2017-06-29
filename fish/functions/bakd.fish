function bakd
    set -l directory {$PWD}/backup_files
    set -l timestamp

    mkdir -p {$directory}

    for f in $argv
        set timestamp ( /bin/ls --full-time {$f} | awk '{print $6"T"$7}' )
        mv {$f} {$directory}/{$f}.{$timestamp}; and cp -a {$directory}/{$f}.{$timestamp} {$f};
    end for
end
