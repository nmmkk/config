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

switch $os
case Linux
    # Originals so that we can restore it later
    set ORIG_PATH $PATH
    set ORIG_MANPATH $MANPATH
    set ORIG_INFOPATH $INFOPATH

    # Make empty directories silently to prevent errors in enable_linuxbrew()
    # on a Linux machine that does not have linuxbrew installed.
    mkdir -p \
        $HOME/.linuxbrew/sbin \
        $HOME/.linuxbrew/bin \
        $HOME/.linuxbrew/share/man \
        $HOME/.linuxbrew/share/info

    # Ones with linuxbrew enabled
    set LB_PATH  $HOME/.linuxbrew/sbin $HOME/.linuxbrew/bin $PATH
    set LB_MANPATH  $HOME/.linuxbrew/share/man $MANPATH
    set LB_INFOPATH  $HOME/.linuxbrew/share/info $INFOPATH
end


#
# Functions
#

function enable_linuxbrew
    if [ $os != "Linux" ]
        echo "You are not on a Linux"
        return 0
    end

    set PATH $LB_PATH
    set MANPATH $LB_MANPATH
    set INFOPATH $LB_INFOPATH
end

function disable_linuxbrew
    if [ $os != "Linux" ]
        echo "You are not on a Linux"
        return 0
    end

    set PATH $ORIG_PATH
    set MANPATH $ORIG_MANPATH
    set INFOPATH $ORIG_INFOPATH
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
end

