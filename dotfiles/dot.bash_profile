#!/usr/bin/env bash

# First, set the XDG Base Directories.
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache

export PATH=${HOME}/.local/bin:${HOME}/bin:${HOME}/tools:${PATH}

export EDITOR="vim"

# To work around an issue at bash start in linuxbrew
# Ref: https://github.com/Linuxbrew/legacy-linuxbrew/issues/46
if [ x"${PKG_CONFIG_PATH}" = x"" ]; then
    export PKG_CONFIG_PATH="/usr/share/pkgconfig"
else
    export PKG_CONFIG_PATH="/usr/share/pkgconfig:${PKG_CONFIG_PATH}"
fi

#------------------------------------------------------------------------------
# Perl
#------------------------------------------------------------------------------
export PERL_LOCAL_LIB_ROOT="${PERL_LOCAL_LIB_ROOT:-${HOME}/perl5}"
export PERL5LIB="${PERL5LIB:-${PERL_LOCAL_LIB_ROOT}/lib/perl5}"

#------------------------------------------------------------------------------
# stow-get
#------------------------------------------------------------------------------

export STOW_TOP="${XDG_DATA_HOME}/stow-get/usr/local"
export PATH="${STOW_TOP}/bin:${PATH}"
export LD_LIBRARY_PATH="${STOW_TOP}/lib64:${STOW_TOP}/lib:${LD_LIBRARY_PATH}"
export PYTHONPATH="${STOW_TOP}/lib64:${STOW_TOP}/lib:${PYTHONPATH}"

#------------------------------------------------------------------------------
# Linuxbrew
#------------------------------------------------------------------------------

# Save the path so that I can use it later to switch PATH for linuxbrew
if [ x"${ORIG_PATH}" = x"" ]; then
    export ORIG_PATH=${PATH}
    export ORIG_MANPATH="${MANPATH}"
    export ORIG_INFOPATH="${INFOPATH}"
    export ORIG_PKG_CONFIG_PATH="${PKG_CONFIG_PATH}"

    # Perl
    export ORIG_PERL5LIB="${PERL5LIB}"
    # Somehow PERL_LOCAL_LIB_ROOT on CentOS 7 started with ':'. And the
    # character let local::lib confused.
    export ORIG_PERL_LOCAL_LIB_ROOT="${PERL_LOCAL_LIB_ROOT#:}"
    # Followings are taken care by local::lib. No backup is needed.
    ### export ORIG_PERL_MB_OPT="${PERM_MB_OPT}"
    ### export ORIG_PERL_MM_OPT="${PERL_MM_OPT}"
fi

if [ -d "${HOME}/.linuxbrew" ]; then
    export LB_TOP="${HOME}/.linuxbrew"
elif [ -d /home/linuxbrew/.linuxbrew ]; then
    export LB_TOP="/home/linuxbrew/.linuxbrew"
fi

export LB_PATH="${LB_TOP}/sbin:${LB_TOP}/bin:${PATH}"
export LB_MANPATH="${LB_TOP}/share/man:${MANPATH}"
export LB_INFOPATH="${LB_TOP}/share/info:${INFOPATH}"
export LB_PKG_CONFIG_PATH="${LB_TOP}/opt/isl@0.18/lib/pkgconfig:/usr/share/pkgconfig:${ORIG_PKG_CONFIG_PATH}"

# Perl
export LB_PERL5_TOP="${XDG_DATA_HOME}/perl5-LB"
export LB_PERL5LIB="${LB_PERL5_TOP}/lib/perl5"
export LB_PERL_LOCAL_LIB_ROOT="${LB_PERL5_TOP}"
if [ ! -d "${LB_PERL5LIB}" ]; then
    mkdir -p "${LB_PERL5LIB}"
fi

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_EMOJI=1

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    # shellcheck disable=SC1090
	. ~/.bashrc
fi
disable_linuxbrew

#------------------------------------------------------------------------------
# Lastly, source the local configuration file
#------------------------------------------------------------------------------
if [ -f "${XDG_CONFIG_HOME}/bash/local.bash_profile" ]; then
    # shellcheck disable=SC1090
    source "${XDG_CONFIG_HOME}/bash/local.bash_profile"
fi
