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
# Environment variables
#

if not set -q EDITOR
    if type nvim >/dev/null 2>/dev/null
        set -gx EDITOR nvim
    else if type vim >/dev/null 2>/dev/null
        set -gx EDITOR vim
    else
        set -gx EDITOR vi
    end
end

if not set -q XDG_DATA_HOME
    set -gx XDG_DATA_HOME $HOME/.local/share
end
if not set -q XDG_CONFIG_HOME
    set -gx XDG_CONFIG_HOME $HOME/.config
end
# set -gx XDG_DATA_DIRS /usr/local/share/:/usr/share/
# set -gx XDG_CONFIG_DIRS /etc/xdg
if not set -q XDG_CACHE_HOME
    set -gx XDG_CACHE_HOME $HOME/.cache
end

#
# PATH
#

# For nodebrew
if type nodebrew >/dev/null 2>/dev/null
    set -gx PATH $HOME/.nodebrew/current/bin $PATH
end

if test -d /Library/TeX/texbin >/dev/null 2>/dev/null
    set -gx PATH /Library/TeX/texbin $PATH
end

# For cargo
if test -d ~/.cargo/bin >/dev/null 2>/dev/null
    set -gx PATH ~/.cargo/bin $PATH
end

# For pyenv and virtualenv
set -gx PATH "$HOME/.pyenv/bin" $PATH
if type pyenv >/dev/null 2>/dev/null
    status --is-interactive; and source (pyenv init -|psub)
end
if type pyenv-virtualenv-init >/dev/null 2>/dev/null
    status --is-interactive; and source (pyenv virtualenv-init -|psub)
end

# For my own stuffs
if test -d ~/Applications/custom/bin >/dev/null 2>/dev/null
    set -gx PATH ~/Applications/custom/bin $PATH
end

# For GNOME Keyring
if test -n "$DESKTOP_SESSION"
    set -x (gnome-keyring-daemon --start | string split "=")
end

# For linuxbrew
switch "$os"
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
# Workaround for xsel error upon <C-w>, <C-u> ... etc.
# The issue was observed on SSH sessions after some moment passes on the session.
# The workaround below is from:
#   [Kill to the clipboard is frustrating · Issue #772 · fish-shell/fish-shell](https://github.com/fish-shell/fish-shell/issues/772)
#
set FISH_CLIPBOARD_CMD "cat" # Stop that.

# omf::theme::bobthefish
set -gx theme_powerline_fonts yes
set -gx theme_color_scheme dracula

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
    if [ "$os" != "Linux" ]
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

# cdg -- bookmarked directory selector
# https://dmitryfrank.com/articles/shell_shortcuts
function fuzzy_finder
    if type fzf >/dev/null 2>/dev/null
        fzf $argv
    else if type peco >/dev/null 2>/dev/null
        peco --layout=bottom-up $argv
    end
end

function cdscuts_list_echo
    sed 's/#.*//g' $argv[1] | sed '/^\s*$/d'
end

function cdscuts_glob_echo
    set -l system_wide_filelist
    set -l user_filelist

    if [ -r /etc/cdg_paths ]
        set system_wide_filelist (cdscuts_list_echo /etc/cdg_paths)
    end
    if [ -r ~/.cdg_paths ]
        set user_filelist (cdscuts_list_echo ~/.cdg_paths)
    end

    for item in $system_wide_filelist $user_filelist
        echo "$item"
    end | sed '/^\s*$/d'
end

function cdg -d 'Bookmarked directory selector'
    if not type fuzzy_finder >/dev/null 2>/dev/null
        echo "No fuzzy finder is available" >&2
        return 1
    end

    set -l dest_dir (cdscuts_glob_echo | fuzzy_finder)
    if set -q dest_dir[1]
        echo cd "$dest_dir"
        cd "$dest_dir"
    end
end

#
# Handy functions with fzf
#   From 
#
function fzf-bcd-widget -d 'cd backwards'
    pwd | awk -v RS=/ '/\n/ {exit} {p=p $0 "/"; print p}' | tail -r | eval (__fzfcmd) +m --select-1 --exit-0 $FZF_BCD_OPTS | read -l result
    [ "$result" ]; and cd $result
    commandline -f repaint
end

function fzf-cdhist-widget -d 'cd to one of the previously visited locations'
    # Clear non-existent folders from cdhist.
    set -l buf
    for i in (seq 1 (count $dirprev))
        set -l dir $dirprev[$i]
        if test -d $dir
            set buf $buf $dir
        end
    end
    set dirprev $buf
    string join \n $dirprev | tail -r | sed 1d | eval (__fzfcmd) +m --tiebreak=index --toggle-sort=ctrl-r $FZF_CDHIST_OPTS | read -l result
    [ "$result" ]; and cd $result
    commandline -f repaint
end

function fzf-select -d 'fzf commandline job and print unescaped selection back to commandline'
	set -l cmd (commandline -j)
	[ "$cmd" ]; or return
	eval $cmd | eval (__fzfcmd) -m --tiebreak=index --select-1 --exit-0 | string join ' ' | read -l result
	[ "$result" ]; and commandline -j -- $result
	commandline -f repaint
end

function fzf-complete -d 'fzf completion and print selection back to commandline'
	# As of 2.6, fish's "complete" function does not understand
	# subcommands. Instead, we use the same hack as __fish_complete_subcommand and
	# extract the subcommand manually.
	set -l cmd (commandline -co) (commandline -ct)
	switch $cmd[1]
		case env sudo
			for i in (seq 2 (count $cmd))
				switch $cmd[$i]
					case '-*'
					case '*=*'
					case '*'
						set cmd $cmd[$i..-1]
						break
				end
			end
	end
	set cmd (string join -- ' ' $cmd)

	set -l complist (complete -C$cmd)
	set -l result
	string join -- \n $complist | sort | eval (__fzfcmd) -m --select-1 --exit-0 --header '(commandline)' | cut -f1 | while read -l r; set result $result $r; end

	set prefix (string sub -s 1 -l 1 -- (commandline -t))
	for i in (seq (count $result))
		set -l r $result[$i]
		switch $prefix
			case "'"
				commandline -t -- (string escape -- $r)
			case '"'
				if string match '*"*' -- $r >/dev/null
					commandline -t --  (string escape -- $r)
				else
					commandline -t -- '"'$r'"'
				end
			case '~'
				commandline -t -- (string sub -s 2 (string escape -n -- $r))
			case '*'
				commandline -t -- (string escape -n -- $r)
		end
		[ $i -lt (count $result) ]; and commandline -i ' '
	end

	commandline -f repaint
end

function fco -d "Fuzzy-find and checkout a branch"
  git branch --all | grep -v HEAD | string trim | fzf | read -l result; and git checkout "$result"
end

function fcoc -d "Fuzzy-find and checkout a commit"
  git log --pretty=oneline --abbrev-commit --reverse | fzf --tac +s -e | awk '{print $1;}' | read -l result; and git checkout "$result"
end

function fssh -d "Fuzzy-find ssh host via rg and ssh into it"
  rg --ignore-case '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf | read -l result; and ssh "$result"
end

function fs -d "Switch tmux session"
  tmux list-sessions -F "#{session_name}" | fzf | read -l result; and tmux switch-client -t "$result"
end

#
# Define key bindings
#
function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
end




#
# Aliases/Baliases
#
# For balias, make sure balias plugin is installed:
#   `fisher oh-my-fish/plugin-balias`
if type git >/dev/null 2>/dev/null
    if type balias >/dev/null 2>/dev/null
        balias g git
    end
end

if type todo.sh >/dev/null 2>/dev/null
    if type balias >/dev/null 2>/dev/null
        balias t todo.sh
    end
    set -gx TODOTXT_DEFAULT_ACTION list
    set -gx TODOTXT_SORT_COMMAND 'env LC_COLLATE=C sort -k 2,2 -k 1,1n'
end

if type jrnl >/dev/null 2>/dev/null
    if type balias >/dev/null 2>/dev/null
        balias j jrnl
    end
end

# switch "$os"
# case Linux
#     if type xdg-open >/dev/null 2>/dev/null
#         if type xdg-open >/dev/null 2>/dev/null
#             balias open xdg-open
#         end
#     end
# end

# Automatically update Brewfile.
# Unfortunately fish is not supported, and the following lines are commented out.
# https://github.com/rcmdnk/homebrew-file/blob/master/docs/brew-wrap.rst
#
# if test -f (brew --prefix)/etc/brew-wrap
#     source (brew --prefix)/etc/brew-wrap
# end

# For fish-pipenv plugin
# -- set if your term supports `pipenv shell --fancy`
set pipenv_fish_fancy yes

# Hook for desk activation
test -n "$DESK_ENV"; and . "$DESK_ENV"; or true

# direnv
if type direnv >/dev/null 2>/dev/null
    direnv hook fish | source
end

# jump
if type jump >/dev/null 2>/dev/null
    status --is-interactive; and source (jump shell fish | psub)
end

# Source local fish configuration
if test -f $XDG_CONFIG_HOME/fish/config-local.fish
    source $XDG_CONFIG_HOME/fish/config-local.fish
end
