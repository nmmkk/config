if type rpm2cpio >/dev/null ^/dev/null ; and type cpio >/dev/null ^/dev/null
    function extract_rpm_files
        set -l usage "Usage: extract_rpm_files <RPM_filename>"

        if test (count $argv) -lt 1
            echo "$usage" >/dev/stderr
            return 1
        end

        set -l rpm_basename (basename $argv[1])
        set -l rpm_dirname (dirname $argv[1])
        set -l extract_to_here "$HOME/work/rpm-files/$rpm_basename"

        if test ! -e "$rpm_dirname/$rpm_basename"
            echo "ERROR: Given RPM file does not exist." >/dev/stderr
            return 2
        end
        if test ! -f "$rpm_dirname/$rpm_basename"
            echo "ERROR: Given RPM name is not of a file." >/dev/stderr
            return 3
        end

        if test -d "$extract_to_here"
            echo "ERROR: Given RPM seems already extracted at $extract_to_here" >/dev/stderr
            return 4
        end

        mkdir -p "$extract_to_here"
        cd "$extract_to_here" ; or return $status
        rpm2cpio "$rpm_dirname/$rpm_basename" | cpio -idmv
        if test $status -ne 0
            echo "ERROR: Failed in rpm command: rpm2cpio \"$rpm_dirname/$rpm_basename\" | cpio -idmv" >/dev/stderr
            return 5
        end
        cd - >/dev/null

        echo "RPM files are just extracted to $extract_to_here"
    end
end

