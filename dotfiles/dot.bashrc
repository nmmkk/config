#!/usr/bin/env bash

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

#------------------------------------------------------------------------------
# Definition
#------------------------------------------------------------------------------

# Prompt
PS1='${LB_ENABLED:+[brew] }#\D{%Y-%m-%dT%H:%M:%S} \u@\h:\w\n\$ '

#------------------------------------------------------------------------------
# Function
#------------------------------------------------------------------------------
is_os()
{
    local this="$1"
    local os=$(uname -o)

    case "${os}" in
        "${this}" )
            return 0
            ;;
        * )
            echo "You are not on ${this}" 1>&2
            return 1
            ;;
    esac
}

# enable_linuxbrew() and disable_linuxbrew() switch a sets of environment
# variables that are already prepared in bash_profile.
enable_linuxbrew ()
{
    is_os "GNU/Linux" || return 0

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
        . "${LB_TOP}"/etc/bash_completion
    fi

    export LB_ENABLED=1
}

disable_linuxbrew()
{
    is_os "GNU/Linux" || return 0

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
    source "${XDG_CONFIG_HOME}/bash/local.bashrc"
fi
