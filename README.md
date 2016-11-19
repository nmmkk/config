# config
vim, zsh, tmux, ... etc


# Usage

## Install

### Install public files from GitHub

    $ git clone git://github.com/nmmk/config.git
    $ cd config
    $ make linux

### Prepare local files

    $ mkdir -p ~/.rcfiles/{vim,zsh}/
    $ cd config
    $ find . -type f -exec grep -IHn -e 'local_.*zsh' -e 'ResourceLocalProfile local_' {} \;

    The `find` command above shows local configuration files to be sourced.
    Create those local configuration files under `~/.rcfiles/{vim,zsh}/` appropriately.

## Update

    $ make update
