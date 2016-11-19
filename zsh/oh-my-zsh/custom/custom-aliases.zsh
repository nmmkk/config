# This file is to define aliases okay to be public.

# aliased ls needs if file/dir completions work
setopt complete_aliases

# OS dependent aliases# {{{
case "${OSTYPE}" in
    freebsd*|darwin*)
        alias ls="ls -G -w -F"
        alias ll='ls -l'
        ;;
    linux*)
        alias ls="ls -F --color"
        alias ll='ls -l --color=tty'
        ;;
esac
# }}}

# Generic aliases# {{{
# alias lf="ls -F"
# alias lsdir='ls -F | grep "\/$"'
# alias su="su -l"
unalias history
alias allhistory='history -nir 0'
alias f="find"
### alias findgrep="find -type f -exec grep -Hn --color" # ==> changed to a function
alias s="svn"
alias g="git"
alias j="jobs -l"
alias la='ls -la'
alias le='ls | grep -ie'
alias lsdir='ls -l | grep "^d"'
alias lt='ls -ltr'
alias p='cd ..'
alias psa="ps auxww"
alias psax="ps axo user,pid,%cpu,%mem,vsz,rsz,tty,stat,start,cputime,etime,args"
alias psaxf="ps axfo user,pid,%cpu,%mem,vsz,rsz,tty,stat,start,cputime,etime,args"
alias screen="TERM=screen screen -U"   # TERMを指定しないと、screenでBSがDelになる <-- 本当?真偽を忘れた...
alias sz="source ~/.zshrc"
alias t="todo.sh"
alias tarc="tar czvf "
alias tarx="tar xzvf "
alias today="date '+%Y%m%d'"    # 例えば 20090601 のように日付が表示される
alias now="date '+%H%M'"        # 例えば 0845 のように日付が表示される
alias view="vim -R"     # CentOS ではデフォルトの view がしょぼいので、置き換える。
alias where="command -v"
alias wt="watch -n 1 fssiteinfo"
alias ssh="ssh -X"
alias gist="gist --private"

# Copy and paste from/to clipboard
# (http://qiita.com/catatsuy/items/0fd67f706366b2355e8f)
alias pbcopy="xsel --clipboard --input"
alias pbpaste="xsel --clipboard --output"
# (http://qiita.com/catatsuy/items/71b0f4932f00c6711ef5)
alias tmux-copy='tmux save-buffer - | pbcopy'
# }}}

# Use vim as pager command "less".
# alias less='/usr/share/vim/vim71/macros/less.sh'

# Global aliases# {{{
# alias -g L='| less'
# alias -g H='| head'
# alias -g T='| tail'
# alias -g G='| grep'
# alias -g GI='| grep -i'
# alias -g S='| sed'
# alias -g A='| awk'
# alias -g W='| wc'
# alias -g X='| xargs'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
# alias -g VM=/var/log/messages
# alias -g EUC='| nkf -e'
# }}}

# 拡張子とコマンドの関連付け# {{{
# alias -s log=tail
# alias -s c=vim
# alias -s h=vim
# alias -s sh=vim
# alias -s txt=less
# alias -s xml=less
# }}}

# For VNC viewer/server# {{{
# alias wres="xrandr --fb 1784x1162_60.00"
alias wres="xrandr --fb 1776x1162_60.00"
alias sres="xrandr --fb 1024x800_60.00"
# }}}

# Source local aliases# {{{
source ~/.rcfiles/zsh/local_aliases.zsh
# }}}

# vim: foldmethod=marker
