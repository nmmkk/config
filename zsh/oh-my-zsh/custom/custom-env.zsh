# This file is to define environment variables okay to be public.

# First, source the local env# {{{1
if [ -f ~/.rcfiles/zsh/local_env.zsh ]; then
    source ~/.rcfiles/zsh/local_env.zsh
fi
# }}}1

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
## Some comands installed by linuxbrew did not seem working fine. It caused build errors in our software product. Enable the followings only as needed.
######### export PATH="${HOME}/.linuxbrew/bin:${PATH}"
######### export MANPATH="${HOME}/.linuxbrew/share/man:${MANPATH}"
######### export INFOPATH="${HOME}/.linuxbrew/share/info:${INFOPATH}"
######### export PATH="${HOME}/.linuxbrew/sbin:${PATH}"

## Use the followings as needed.
## e.g.) export PATH="${LB_PATH}" && export MANPATH="${LB_MANPATH}" && export INFOPATH="${LB_INFOPATH}"
export LB_PATH="${HOME}/.linuxbrew/sbin:${HOME}/.linuxbrew/bin:${PATH}"
export LB_MANPATH="${HOME}/.linuxbrew/share/man:${MANPATH}"
export LB_INFOPATH="${HOME}/.linuxbrew/share/info:${INFOPATH}"
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

# vim: foldmethod=marker
