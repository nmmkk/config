# config.fish

#
# Determine machine type
#
switch (uname)
case Linux
    set os "Linux"
case Darwin
    set os "macOS"
case FreeBSD NetBSD DragonFly
    set os "BSD"
case '*'
    set os "Undetermined"
end

#
# PATH
#

# For nodebrew
if type nodebrew >/dev/null ^/dev/null
    set -gx PATH $HOME/.nodebrew/current/bin $PATH
end

switch $os
case Linux
    # Originals so that we can restore it later
    set -gx FISH_ORIG_PATH $PATH
    set -gx FISH_ORIG_MANPATH $MANPATH
    set -gx FISH_ORIG_INFOPATH $INFOPATH

    # Make empty directories silently to prevent errors in enable_linuxbrew()
    # on a Linux machine that does not have linuxbrew installed.
    mkdir -p \
        $HOME/.linuxbrew/sbin \
        $HOME/.linuxbrew/bin \
        $HOME/.linuxbrew/share/man \
        $HOME/.linuxbrew/share/info

    # Ones with linuxbrew enabled
    set -gx FISH_LB_PATH  $HOME/.linuxbrew/sbin $HOME/.linuxbrew/bin $PATH
    set -gx FISH_LB_MANPATH  $HOME/.linuxbrew/share/man $MANPATH
    set -gx FISH_LB_INFOPATH  $HOME/.linuxbrew/share/info $INFOPATH
end

#
# Environment variables
#

set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CONFIG_HOME $HOME/.config
# set -gx XDG_DATA_DIRS /usr/local/share/:/usr/share/
# set -gx XDG_CONFIG_DIRS /etc/xdg
set -gx XDG_CACHE_HOME $HOME/.cache

#
# Workarond for xsel error upon <C-w>, <C-u> ... etc.
# The issue was observed on SSH sessions after some moment passes on the session.
# The workaround below is from:
#   [Kill to the clipboard is frustrating · Issue #772 · fish-shell/fish-shell](https://github.com/fish-shell/fish-shell/issues/772)
#
set FISH_CLIPBOARD_CMD "cat" # Stop that.

# omf::theme::bobthefish
set -gx theme_powerline_fonts no
set -gx theme_color_scheme solarized

#
# Functions
#

function enable_linuxbrew
    if [ $os != "Linux" ]
        echo "You are not on a Linux"
        return 0
    end

    set PATH $FISH_LB_PATH
    set MANPATH $FISH_LB_MANPATH
    set INFOPATH $FISH_LB_INFOPATH
end

function disable_linuxbrew
    if [ $os != "Linux" ]
        echo "You are not on a Linux"
        return 0
    end

    set PATH $FISH_ORIG_PATH
    set MANPATH $FISH_ORIG_MANPATH
    set INFOPATH $FISH_ORIG_INFOPATH
end

# [bashで言うところの!$はfishではどうすればよいか - Qiita](http://qiita.com/ymko/items/d7c5c4d0cc6174d5fc86)
function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end




#
# Define key bindings
#
function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar

    # [fish shell を使いたい人生だった ｜ Developers.IO](http://dev.classmethod.jp/etc/fish-shell-life/)
    bind \cr 'peco_select_history (commandline -b)'
end




#
# Aliases/Baliases
#
# For balias, make sure balias plugin is installed:
#   `fisher oh-my-fish/plugin-balias`
if type git >/dev/null ^/dev/null
    balias g git
end

if type todo.sh >/dev/null ^/dev/null
    balias t todo.sh
    set -gx TODOTXT_DEFAULT_ACTION list
    set -gx TODOTXT_SORT_COMMAND 'env LC_COLLATE=C sort -k 2,2 -k 1,1n'
end

if type jrnl >/dev/null ^/dev/null
    balias j jrnl
end

