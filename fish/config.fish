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
    # Take a backup of environment variables so that we can restore it later.
    # Be warn that bash might have already enabled linuxbrew. So rather take a
    # backup of environment variables named "ORIG_*" than of the real ones
    # (like $PATH, $MANPATH, ... etc).
    if not set -q ORIG_PATH
        # Use eval to expand the value. Otherwise whole contents of "(echo
        # $PATH | sed 's/:/ /g')" is packed into a single element.
        eval set -gx ORIG_PATH (echo $PATH | sed 's/:/ /g')
    else
        eval set -gx ORIG_PATH (echo $ORIG_PATH | sed 's/:/ /g')
    end

    if not set -q ORIG_MANPATH
        set -gx ORIG_MANPATH $MANPATH
    end

    if not set -q ORIG_INFOPATH
        set -gx ORIG_INFOPATH $INFOPATH
    end

    if not set -q ORIG_PKG_CONFIG_PATH
        set -gx ORIG_PKG_CONFIG_PATH $PKG_CONFIG_PATH
    end

    if not set -q ORIG_PERL5LIB
        set -gx ORIG_PERL5LIB $PERL5LIB
    end

    if not set -q ORIG_PERL_LOCAL_LIB_ROOT
        set -gx ORIG_PERL_LOCAL_LIB_ROOT $PERL_LOCAL_LIB_ROOT
    end

    # Make empty directories silently to prevent errors in enable_linuxbrew()
    # on a Linux machine that does not have linuxbrew installed.
    mkdir -p \
        $HOME/.linuxbrew/sbin \
        $HOME/.linuxbrew/bin \
        $HOME/.linuxbrew/share/man \
        $HOME/.linuxbrew/share/info

    # Ones with linuxbrew enabled
    if not set -q LB_TOP
        if test -d $HOME/.linuxbrew
            set -gx LB_TOP $HOME/.linuxbrew
        else if test -d /home/linuxbrew/.linuxbrew
            set -gx LB_TOP /home/linuxbrew/.linuxbrew
        end
    end

    # Use eval to expand the value. Otherwise whole contents of $ORIG_PATH goes
    # into an element.
    eval set -gx LB_PATH $LB_TOP/sbin $LB_TOP/bin (echo $ORIG_PATH | sed 's/:/ /g')
    set -gx LB_MANPATH $LB_TOP/share/man $MANPATH
    set -gx LB_INFOPATH $LB_TOP/share/info $INFOPATH
    set -gx LB_PKG_CONFIG_PATH  $LB_TOP/opt/isl@0.18/lib/pkgconfig /usr/share/pkgconfig $ORIG_PKG_CONFIG_PATH

    set -gx LB_PERL5_TOP $XDG_DATA_HOME/perl5-LB
    set -gx LB_PERL5LIB $LB_PERL5_TOP/lib/perl5
    set -gx LB_PERL_LOCAL_LIB_ROOT $LB_PERL5_TOP

    set -gx HOMEBREW_NO_ANALYTICS 1
    set -gx HOMEBREW_NO_EMOJI 1
end

#
# Environment variables
#

if set -q XDG_DATA_HOME
    set -gx XDG_DATA_HOME $HOME/.local/share
end
if set -q XDG_CONFIG_HOME
    set -gx XDG_CONFIG_HOME $HOME/.config
end
# set -gx XDG_DATA_DIRS /usr/local/share/:/usr/share/
# set -gx XDG_CONFIG_DIRS /etc/xdg
if set -q XDG_CACHE_HOME
    set -gx XDG_CACHE_HOME $HOME/.cache
end

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

    set -gx PATH $LB_PATH
    set -gx MANPATH $LB_MANPATH
    set -gx INFOPATH $LB_INFOPATH

    set -gx LB_ENABLED 1
end

function disable_linuxbrew
    if [ $os != "Linux" ]
        echo "You are not on a Linux"
        return 0
    end

    set -gx PATH $ORIG_PATH
    set -gx MANPATH $ORIG_MANPATH
    set -gx INFOPATH $ORIG_INFOPATH

    set -gx LB_ENABLED
end

function show_if_lb_enabled -d 'Show if Linuxbrew is enabled, mainly for the prompt'
    if [ x"$LB_ENABLED" = x"1" ]
        set_color $fish_color_error
        echo " LB"
        set_color $fish_color_autosuggestion
    end
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

