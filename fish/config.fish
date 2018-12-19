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

if test -d /Library/TeX/texbin >/dev/null ^/dev/null
    set -gx PATH /Library/TeX/texbin $PATH
end

# For stow
set -gx STOW_TOP $XDG_DATA_HOME/stow-get/usr/local
set -gx PATH $STOW_TOP/bin $PATH
set -gx LD_LIBRARY_PATH $STOW_TOP/lib64 $STOW_TOP/lib $LD_LIBRARY_PATH
set -gx PYTHONPATH $STOW_TOP/lib64:$STOW_TOP/lib:$PYTHONPATH
if [ x"$os" = x"Darwin" ]
    if type -q pip3
        set __EXTRA_PPATH (pip3 show neovim | grep Location | awk '{print $2}')
        if [ x"$__EXTRA_PPATH" != x"" ]
            set -gx PYTHONPATH $PYTHONPATH:$__EXTRA_PPATH
        end
        unset __EXTRA_PPATH
    end
end

if test -d ~/.cargo/bin >/dev/null ^/dev/null
    set -gx PATH ~/.cargo/bin $PATH
end

switch $os
case Linux
    # Take a backup of environment variables so that we can restore it later.
    # Be warn that bash might have already enabled linuxbrew. So rather take a
    # backup of environment variables named "ORIG_*" than of the real ones
    # (like $PATH, $MANPATH, ... etc).
    # Also, note that we should not convert ":" in $PATH or $ORIG_PATH at this
    # moment. $ORIG_PATH should keep using ":" as delimiter so that we can
    # invoke bash or zsh from current fish environment.
    if not set -q ORIG_PATH
        set -gx ORIG_PATH $PATH
    else
        set -gx ORIG_PATH $ORIG_PATH
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

    # Note that we should not convert ":" in $LB_PATH at this moment. $LB_PATH
    # should keep using ":" as delimiter so that we can invoke bash or zsh from
    # current fish environment.
    set -gx LB_PATH "$LB_TOP/sbin:$LB_TOP/bin:$ORIG_PATH"
    set -gx LB_MANPATH "$LB_TOP/share/man:$MANPATH"
    set -gx LB_INFOPATH "$LB_TOP/share/info:$INFOPATH"
    set -gx LB_PKG_CONFIG_PATH "$LB_TOP/opt/isl@0.18/lib/pkgconfig:/usr/share/pkgconfig:$ORIG_PKG_CONFIG_PATH"

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
# Workaround for xsel error upon <C-w>, <C-u> ... etc.
# The issue was observed on SSH sessions after some moment passes on the session.
# The workaround below is from:
#   [Kill to the clipboard is frustrating · Issue #772 · fish-shell/fish-shell](https://github.com/fish-shell/fish-shell/issues/772)
#
set FISH_CLIPBOARD_CMD "cat" # Stop that.

# omf::theme::bobthefish
set -gx theme_powerline_fonts no
set -gx theme_color_scheme solarized

set -gx theme_display_git yes
set -gx theme_display_git_dirty yes
# The following makes fish slow down under a large git repository
set -gx theme_display_git_untracked no
set -gx theme_display_git_ahead_verbose yes
set -gx theme_display_git_dirty_verbose yes
set -gx theme_display_git_master_branch yes

#
# Functions
#

function enable_linuxbrew
    if [ $os != "Linux" ]
        echo "You are not on a Linux"
        return 0
    end

    # PATH is special. The delimiter is different between bash/zsh and fish. So
    # replace all ";" into " " here.
    # Note that the following line uses eval to expand the value. Otherwise
    # whole contents of "(echo $PATH | sed 's/:/ /g')" are packed into a single
    # element.
    eval set -gx PATH (echo $LB_PATH | sed 's/:/ /g')
    set -gx MANPATH $LB_MANPATH
    set -gx INFOPATH $LB_INFOPATH

    set -gx LB_ENABLED 1
end

function disable_linuxbrew
    if [ $os != "Linux" ]
        echo "You are not on a Linux"
        return 0
    end

    # PATH is special. See the comment in enable_linuxbrew().
    eval set -gx PATH (echo $ORIG_PATH | sed 's/:/ /g')
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

# Automatically update Brewfile.
# Unfortunately fish is not supported, and the following lines are commented out.
# https://github.com/rcmdnk/homebrew-file/blob/master/docs/brew-wrap.rst
#
# if test -f (brew --prefix)/etc/brew-wrap
#     source (brew --prefix)/etc/brew-wrap
# end
