# This file is to define environment variables okay to be public.

# Generic environment variables# {{{1
# export LANG=ja_JP.UTF-8
# export LANG=ja_JP.eucJP
# export LIBXCB_ALLOW_SLOPPY_LOCK=1     # What was the purpose of this?
export LESS='-R'    # to enable coloring
# PAGER=lv          # needed on CentOS 5
export EDITOR=vim

export PATH=$PATH:${HOME}/tools

# }}}1

# Linuxbrew # {{{1

# enable_linuxbrew() and disable_linuxbrew() set the following sets of
# environment variables.
export LB_HOME=${HOME}/.linuxbrew
export LB_PATH="${HOME}/.linuxbrew/sbin:${HOME}/.linuxbrew/bin:${PATH}"
export LB_MANPATH="${HOME}/.linuxbrew/share/man:${MANPATH}"
export LB_INFOPATH="${HOME}/.linuxbrew/share/info:${INFOPATH}"
# export LB_PKG_CONFIG_PATH="${LB_HOME}/lib64/pkgconfig:${LB_HOME}/lib/pkgconfig:${PKG_CONFIG_PATH}"

export ORIG_PATH="${PATH}"
export ORIG_MANPATH="${MANPATH}"
export ORIG_INFOPATH="${INFOPATH}"
# export ORIG_PKG_CONFIG_PATH="${PKG_CONFIG_PATH}"
# }}}1

# GNU Global# {{{1
# Pygments to extend GNU GLOBAL supports for more languages like Python, Perl, Vimm, and more.
export GTAGSCONF=/usr/local/share/gtags/gtags.conf
export GTAGSLABEL=pygments
# }}}1

# Characters to be recognized as a part of a word# {{{1
WORDCHARS='*?_-.~=&[](){}<>'
# }}}1

# A product I have worked on was not happy if LC_CTYPE was set.# {{{1
# (Build system encountered an issue when generating error message catalog in
#  non-UTF characters.)
unset LC_CTYPE
# }}}1

# todo.txt-cli #{{{1
# * [Tips and Tricks](https://github.com/ginatrapani/todo.txt-cli/wiki/Tips-and-Tricks)

# Allow t to list outstanding tasks
export TODOTXT_DEFAULT_ACTION=ls

# Sort your output by priority, then by number
export TODOTXT_SORT_COMMAND='env LC_COLLATE=C sort -k 2,2 -k 1,1n'
# }}}1

# Lastly, source the local env# {{{1
if [ -f ~/.rcfiles/zsh/local_env.zsh ]; then
    source ~/.rcfiles/zsh/local_env.zsh
fi
# }}}1

# vim: foldmethod=marker
