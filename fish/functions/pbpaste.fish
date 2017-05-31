if type xsel >/dev/null ^/dev/null
    function pbpaste
        set -l usage "Usage: pbpaste"

        if test (uname) = "Darwin"
            # If running on macOS, use the genuine pbpaste.
            return 0
        end

        if test (count $argv) -ge 1
            echo "$usage" >/dev/stderr
            return 1
        end

        xsel --clipboard --output
    end
end

