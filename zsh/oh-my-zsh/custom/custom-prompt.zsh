# #----------------------------------------
# # プロンプト
# #----------------------------------------
# 
# # プロンプト用の初期設定
# autoload colors
# colors
# 
# autoload promptinit         # プロンプトのテーマ
# promptinit
# 
# # export PS1="$(ppwd \l)\u@\h:\w> "
# # export PS1="\[\e[1;32m\]\u@\h:\W> \[\e[0m\]"
# # export PS1="\[\e[1;30m\]\u@\h:\W> \[\e[0m\]"
# # PROMPT="%m:%n%% "
# # case ${UID} in
# # 0)
# #  PROMPT="%n@%m> "
# #  RPROMPT="[%~]"
# #  SPROMPT="correct: %R -> %r ? "
# #  ;;
# # *)
# #  PROMPT="%n@%m> "
# #  RPROMPT="[%~]"
# #  SPROMPT="correct: %R -> %r ? "
# #  ;;
# # esac
# 
# #
# # %n : user name
# # %j : running job count
# # %~ : current directory
# #
# case ${UID} in
# 0)
#   PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
#   PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
#   SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
#   if [ -n "${REMOTEHOST}${SSH_CONNECTION}" ]; then
#     PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
#     # Doing ssh from RHEL7 to CentOS 5.6 encountered terminal problems due to "screen-256color",
#     #  which is not supported by the screen on CentOS 5.6 . To prevent it, change TERM setting.
#     [ "${TERM}" = "screen-256color" ] && TERM=screen
#   fi
#   ;;
# *)
#   PROMPT="%{${bg[white]}%}%{${fg[red]}%}%n%{${fg[yellow]}%}@%{${fg[red]}%}${HOST%%.*} %{${fg[green]}%}%D.%*%{${fg[blue]}%}[%~]%{${reset_color}%}
# %{${fg[yellow]}%}>%{${reset_color}%} "
#   SPROMPT="correct: %R -> %r ? " 
#   if [ -n "${REMOTEHOST}${SSH_CONNECTION}" ]; then
#     # Doing ssh from RHEL7 to CentOS 5.6 encountered terminal problems due to "screen-256color",
#     #  which is not supported by the screen on CentOS 5.6 . To prevent it, change TERM setting.
#     ##### [ "${TERM}" = "screen-256color" ] && TERM=screen
#   fi
#   ;;
# esac
# 
# ## terminal configuration
# #
# unset LSCOLORS
# case "${TERM}" in
# xterm)
#   export TERM=xterm-color
#   ;;
# kterm)
#   export TERM=kterm-color
#   # set BackSpace control character
#   stty erase
#   ;;
# cons25)
#   unset LANG
#   export LSCOLORS=ExFxCxdxBxegedabagacad
#   export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#   zstyle ':completion:*' list-colors \
#     'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
#   ;;
# esac
# 
# # set terminal title including current directory
# #
# case "${TERM}" in
# kterm*|xterm*)
#   precmd() {
#     echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
#   }
#   export LSCOLORS=exfxcxdxbxegedabagacad
#   export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#   zstyle ':completion:*' list-colors \
#     'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
#   ;;
# esac


#----------------------------------------
# GIT
#----------------------------------------

# # git stash count
# function git_prompt_stash_count {
#   local COUNT=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
#   if [ "$COUNT" -gt 0 ]; then
#     echo " ($COUNT)"
#   fi
# }
# 
# setopt prompt_subst
# autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
# 
# function rprompt-git-current-branch {
#   local name st color action
# 
#   if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
#     return
#   fi
# 
#   name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
#   if [[ -z $name ]]; then
#     return
#   fi
# 
#   st=`git status 2> /dev/null`
#   if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
#     color=${fg[blue]}
#   elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
#     color=${fg[yellow]}
#   elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
#     color=${fg_bold[red]}
#   else
#     color=${fg[red]}
#   fi
# 
#   gitdir=`git rev-parse --git-dir 2> /dev/null`
#   action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"
# 
#   # %{...%} surrounds escape string
#   echo "%{$color%}$name$action`git_prompt_stash_count`$color%{$reset_color%}"
# }
# 
# # how to use
# PROMPT='`rprompt-git-current-branch`'
# 
