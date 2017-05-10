if type cvs >/dev/null ^/dev/null
    function cvsgetrev --description 'Obtain the specified version of file from the CVS'
        set -l usage "Usage: cvsgetrev <filename> <rev>"

        if test (count $argv) -lt 2
            echo "$usage" >/dev/stderr
            return 1
        end

        set -l filename $argv[1]
        set -l rev $argv[2]

        if test ! -e "$filename"
            echo "The given target file does not exist" >/dev/stderr
            echo "$usage" >/dev/stderr
            return 2
        end

        if test -e "$filename--$rev"
            echo "The specified file/revision is already saved at $filename--$rev"
            return 0
        end

        echo "Executing: cvs -Q up -p -r $rev $filename > $filename--$rev"
        cvs -Q up -p -r $rev $filename > $filename--$rev
        return $status
    end
end
