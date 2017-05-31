if type xsel >/dev/null ^/dev/null
    function pbcopy
        set -l usage "Usage: pbcopy"

        if test (uname) = "Darwin"
            # If running on macOS, use the genuine pbcopy.
            return 0
        end

        if test (count $argv) -ge 1
            echo "$usage" >/dev/stderr
            return 1
        end

        xsel --clipboard --input
    end
end

