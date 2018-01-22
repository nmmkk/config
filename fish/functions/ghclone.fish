if type git >/dev/null ^/dev/null
    function ghclone --description 'GitHub Clone -- Clone the given GitHub repository and put the tree under a predetermined place'
        set -l usage "Usage: ghclone <repo_url>"
        set -l clone_root "$HOME/sandbox/gitwork/github"

        if test (count $argv) -lt 1
            echo "$usage" >/dev/stderr
            return 1
        end

        set -l repository $argv[1]

        if not string match -r 'github.com' $repository >/dev/null ^/dev/null
            echo "The given repository does not look like of GitHub" >/dev/stderr
            echo "$usage" >/dev/stderr
            return 2
        end

        # Extract author name and repository name
        set -l split_repo (string split -rm2 / "$repository")
        set -l author $split_repo[2]
        # I would like to remove '.git' from repository name
        set -l buf (string split -m1 . $split_repo[3])
        set -l repo_name $buf[1]
        set --erase buf
        set --erase split_repo
        set -l clone_here $clone_root/$author

        # Prepare the location where I clone
        mkdir -pv $clone_here
        if not cd $clone_here
            echo "Failed to change directory to $clone_here"
            return 3
        end

        if git clone $repository $repo_name
            echo ""
            echo "Congraturations! Repository is just cloned at $clone_here/$repo_name"
            echo ""
            return 0
        else
            echo "ERROR: Failed to clone $repository" >/dev/stderr
            return 4
        end
    end
end
