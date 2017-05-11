if type rpm >/dev/null ^/dev/null
    function extract_rpm_scripts
        set -l usage "Usage: extract_rpm_scripts <RPM_filename>"

        if test (count $argv) -lt 1
            echo "$usage" >/dev/stderr
            return 1
        end

        set -l rpm_basename (basename $argv[1])
        set -l rpm_dirname (dirname $argv[1])
        set -l extract_to_here "$HOME/work/rpm-scripts/$rpm_basename"

        if test ! -e "$rpm_dirname/$rpm_basename"
            echo "ERROR: Given RPM file does not exist." >/dev/stderr
            return 2
        end
        if test ! -f "$rpm_dirname/$rpm_basename"
            echo "ERROR: Given RPM name is not of a file." >/dev/stderr
            return 3
        end

        mkdir -p "(dirname $extract_to_here)"
        rpm -qp --scripts "$rpm_dirname/$rpm_basename" > "$extract_to_here"
        if test $status -ne 0
            echo "ERROR: Failed in rpm command: rpm -qp --scripts \"$rpm_dirname/$rpm_basename\"" >/dev/stderr
            return 4
        end

        echo "RPM scripts are just extracted to $extract_to_here"
    end
end

