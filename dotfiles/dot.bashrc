#!/usr/bin/env bash

# Source global definitions
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Define ANSI colors and formatting
if [ "${TERM:-dumb}" != "dumb" ]; then
    TXTUNDERLINE='\e[4m'
    TXTBOLD='\e[1m'
    TXTRED='\e[31m'
    TXTGREEN='\e[32m'
    TXTYELLOW='\e[33m'
    TXTBLUE='\e[34m'
    TXTRESET='\e[0m'
else
    # shellcheck disable=SC2034
    TXTUNDERLINE=""
    # shellcheck disable=SC2034
    TXTBOLD=""
    # shellcheck disable=SC2034
    TXTRED=""
    # shellcheck disable=SC2034
    TXTGREEN=""
    # shellcheck disable=SC2034
    TXTYELLOW=""
    # shellcheck disable=SC2034
    TXTBLUE=$""
    # shellcheck disable=SC2034
    TXTRESET=""
fi

#------------------------------------------------------------------------------
# Definition
#------------------------------------------------------------------------------

# Prompt
# If jm-shell is installed, use it with 'extensive' style.
# https://github.com/jmcclare/jm-shell
jm_shell_ps1="${HOME}/.local/lib/bash/ps1"
if [ -r "${jm_shell_ps1}" ]; then
    # shellcheck disable=SC2034
    prompt_style=default
    # shellcheck disable=SC1090
    source "${jm_shell_ps1}"
else
    PS1="\$(\
        ret=\$?; \
        if [ x\"\${LB_ENABLED}\" = x\"1\" ]; then \
            printf '${TXTBLUE}[brew]${TXTRESET} '; \
        fi; \
        printf '#\!'; \
        if [ \$ret -eq 0 ]; then \
            printf '|%d' \$ret; \
        else \
            printf '|${TXTRED}%d${TXTRESET}' \$ret; \
        fi; \
        printf '|\D{%Y-%m-%dT%H:%M:%S} \u@\h:\w\n\$ '; \
    )"
fi

#------------------------------------------------------------------------------
# Function
#------------------------------------------------------------------------------
get_caller_line()
{
    echo "${BASH_SOURCE[2]##*/}@${BASH_LINENO[1]}"
}

is_os()
{
    local this="$1"
    local os=

    os="$(uname)"

    case "${os}" in
        "${this}" )
            return 0
            ;;
        * )
            # echo "$(get_caller_line) | You are not on ${this}" 1>&2
            return 1
            ;;
    esac
}

# enable_linuxbrew() and disable_linuxbrew() switch a sets of environment
# variables that are already prepared in bash_profile.
enable_linuxbrew ()
{
    is_os "Linux" || return 0

    if [ x"${LB_PATH}" = x"" ]; then
        # We should not print out anything in bashrc. Otherwise rsync via ssh
        # complains about protocol version. See "DIAGNOSTICS" section in man
        # rsync.
        ### # echo "Linuxbrew is not set up"
        return 1
    fi

    export PATH="${LB_PATH}"
    export MANPATH="${LB_MANPATH}"
    export INFOPATH="${LB_INFOPATH}"
    export PKG_CONFIG_PATH="${LB_PKG_CONFIG_PATH}"

    # `brew install perl` suggests:
    #   By default non-brewed cpan modules are installed to the Cellar. If you wish
    #   for your modules to persist across updates we recommend using `local::lib`.
    #
    #   You can set that up like this:
    #     PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
    #     echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"' >> ~/.bash_profile
    #
    # Unset first, otherwise Linuxbrew paths are appended in PERL5LIB and
    # PERL_LOCAL_LIB_ROOT .
    unset PERL5LIB PERL_LOCAL_LIB_ROOT PERL_MB_OPT PERL_MM_OPT
    eval "$(perl -I"${LB_PERL5LIB}" -Mlocal::lib="${LB_PERL_LOCAL_LIB_ROOT}")"

    # `brew install bash-completion` suggests:
    # Add the following line to your ~/.bash_profile:
    #   [ -f $HOME/.linuxbrew/etc/bash_completion ] && . $HOME/.linuxbrew/etc/bash_completion
    #
    #   Bash completion has been installed to:
    #     /home/username/.linuxbrew/etc/bash_completion.d
    if [ -f "${LB_TOP}"/etc/bash_completion ]; then
        # shellcheck disable=SC1090
        source "${LB_TOP}"/etc/bash_completion
    fi

    export LB_ENABLED=1
}

disable_linuxbrew()
{
    is_os "Linux" || return 0

    if [ x"${ORIG_PATH}" = x"" ]; then
        echo "ORIG_PATH is not set up"
        return 1
    fi

    export PATH="${ORIG_PATH}"
    export MANPATH="${ORIG_MANPATH}"
    export INFOPATH="${ORIG_INFOPATH}"
    export PKG_CONFIG_PATH="${ORIG_PKG_CONFIG_PATH}"

    # Unset first, otherwise Linuxbrew paths are appended in PERL5LIB and
    # PERL_LOCAL_LIB_ROOT .
    unset PERL5LIB PERL_LOCAL_LIB_ROOT PERL_MB_OPT PERL_MM_OPT
    eval "$(perl -I"${ORIG_PERL5LIB}" -Mlocal::lib="${ORIG_PERL_LOCAL_LIB_ROOT}")"

    ### TODO: How can we restore bash_completion?
    ### if [ -f "${LB_TOP}"/etc/bash_completion ]; then
    ###     . "${LB_TOP}"/etc/bash_completion
    ### fi

    export LB_ENABLED=
}

### Following part takes a couple of seconds. Slow.
### # Initialize linuxbrew.
### if enable_linuxbrew; then
###     if [ -f "$(brew --prefix)/etc/brew-wrap" ]; then
###         # shellcheck disable=SC1090
###         source "$(brew --prefix)/etc/brew-wrap"
###     fi
###     disable_linuxbrew
### fi

#------------------------------------------------------------------------------
# cdg function -- bookmarked directory selector
# https://dmitryfrank.com/articles/shell_shortcuts

#-----------------------------------------
# /usr/bin/cdscuts_list_echo
#-----------------------------------------
# #!/bin/bash
#
# cat $1 | sed 's/#.*//g' | sed '/^\s*$/d'

#-----------------------------------------
# /usr/bin/cdscuts_glob_echo
#-----------------------------------------
# #!/bin/bash
#
# system_wide_filelist=''
# user_filelist=''
#
# if [ -r /etc/cdg_paths ]; then
#    system_wide_filelist=$(cdscuts_list_echo /etc/cdg_paths)
# fi
# if [ -r ~/.cdg_paths ]; then
#    user_filelist=$(cdscuts_list_echo ~/.cdg_paths)
# fi
#
# echo -e "$system_wide_filelist\n$user_filelist" | sed '/^\s*$/d'

#-----------------------------------------
# ~/.cdg_paths
#-----------------------------------------
# /path/to/first_bookmark    # probably some comment
# /path/to/second_bookmark
#
# /path/to/third_bookmark

cdscuts_list_echo()
{
    sed 's/#.*//g' "${1}" | sed '/^\s*$/d'
}

cdscuts_glob_echo()
{
    local system_wide_filelist=''
    local user_filelist=''

    if [ -r /etc/cdg_paths ]; then
        system_wide_filelist=$(cdscuts_list_echo /etc/cdg_paths)
    fi
    if [ -r ~/.cdg_paths ]; then
        user_filelist=$(cdscuts_list_echo ~/.cdg_paths)
    fi

    echo -e "$system_wide_filelist\n$user_filelist" | sed '/^\s*$/d'
}

unalias cdg 2> /dev/null
cdg()
{
    local fuzzy_finder=

    if type peco >/dev/null 2>&1; then
        fuzzy_finder="peco --layout=bottom-up"
    else
        echo "No fuzzy finder is available" >&2
        return 1
    fi

    local dest_dir=$(cdscuts_glob_echo | ${fuzzy_finder})
    if [[ $dest_dir != '' ]]; then
        echo cd "$dest_dir"
        cd "$dest_dir"
    fi
}
# export -f cdg > /dev/null

#------------------------------------------------------------------------------
# Alias
#------------------------------------------------------------------------------
alias p='cd ..'
alias ll='ls -l'
alias la='ls -la'
alias lt='ls -ltr'
alias le='ls | grep -ie'
alias screen="screen -U"

#------------------------------------------------------------------------------
# Shell option
#------------------------------------------------------------------------------
shopt | grep direxpand > /dev/null && shopt -s direxpand

#------------------------------------------------------------------------------
# Lastly, source the local configuration file
#------------------------------------------------------------------------------
if [ -f "${XDG_CONFIG_HOME}/bash/local.bashrc" ]; then
    # shellcheck disable=SC1090
    source "${XDG_CONFIG_HOME}/bash/local.bashrc"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
