if type cvs >/dev/null ^/dev/null
    function cvsgetrev --description 'Obtain the specified version of file from the CVS'
        set -l filename $argv[1]
        set -l rev $argv[2]

        if test x"$filename" = x""
            echo "A target file name needs to be specified" >/dev/stderr
            return 1
        end

        if test x"$rev" = x""
            echo "A target CVS revision needs to be specified" >/dev/stderr
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
