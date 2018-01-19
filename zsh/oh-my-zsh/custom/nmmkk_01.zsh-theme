# My zsh theme

# Basically this settings were copied from http://qiita.com/takc923/items/c479e38112b913b7614a
# Then modified a bit.

# this theme depends on git plugin.

function str_with_color() {# {{{1
    echo "%{$fg[$1]%}$2%{$reset_color%}"
}
# }}}1

function str_with_color_bgbg() {# {{{
    echo "%{${bg[$1]}%}%{$fg[$2]%}$3%{$reset_color%}"
}
# }}}

# Define colors# {{{
ZSH_THEME_GIT_PROMPT_ADDED=$(str_with_color cyan '+')
ZSH_THEME_GIT_PROMPT_MODIFIED=$(str_with_color yellow '*')
ZSH_THEME_GIT_PROMPT_DELETED=$(str_with_color red 'x')
ZSH_THEME_GIT_PROMPT_RENAMED=$(str_with_color blue 'o')
ZSH_THEME_GIT_PROMPT_UNMERGED=$(str_with_color magenta '!')
ZSH_THEME_GIT_PROMPT_UNTRACKED=$(str_with_color grey '?')
# }}}

function my_git_status() {# {{{
    # [ $(current_branch) ] && echo "($(current_branch)$(git_prompt_status))"  # Too slow on some repository
    [ $(current_branch) ] && echo "($(current_branch))"
}
# }}}

if [ x = xy ]; then
    # Good for light background# {{{
    DATE_TIME=$(str_with_color red '%D{%Y-%m-%dT%K:%M:%S}')
    PROMPT_PREFIX=$(str_with_color grey '#')
    SEPARATOR1=$(str_with_color grey '|')
    USER_NAME=$(str_with_color blue '%n')
    SEPARATOR2=$(str_with_color grey '@')
    HOST_NAME=$(str_with_color cyan '%m')
    SEPARATOR3=$(str_with_color grey ':')
    CURRENT_DIRECTORY=$(str_with_color green '%~')
    PROMPT_CHAR=$(str_with_color grey '$ ')
    PROMPT='${PROMPT_PREFIX}${DATE_TIME}${SEPARATOR1}${USER_NAME}${SEPARATOR2}${HOST_NAME}${SEPARATOR3}${CURRENT_DIRECTORY} $(my_git_status)
$PROMPT_CHAR'
    PROMPT2=$(str_with_color grey '> ')
    SSH_REMOTE_HOST=$(str_with_color black '(ssh from ${SSH_CONNECTION%%" "*})')
    # }}}
else
    # Good for dark background# {{{
    DATE_TIME=$(str_with_color red '%D{%Y-%m-%dT%K:%M:%S}')
    PROMPT_PREFIX=$(str_with_color white '#')
    SEPARATOR1=$(str_with_color white '|')
    USER_NAME=$(str_with_color green '%n')
    SEPARATOR2=$(str_with_color white '@')
    HOST_NAME=$(str_with_color cyan '%m')
    SEPARATOR3=$(str_with_color white ':')
    CURRENT_DIRECTORY=$(str_with_color green '%~')
    PROMPT_CHAR=$(str_with_color white '$ ')
    PROMPT='${PROMPT_PREFIX}${DATE_TIME}${SEPARATOR1}${USER_NAME}${SEPARATOR2}${HOST_NAME}${SEPARATOR3}${CURRENT_DIRECTORY} $(my_git_status)
$PROMPT_CHAR'
    PROMPT2=$(str_with_color grey '> ')
    SSH_REMOTE_HOST=$(str_with_color white '(ssh from ${SSH_CONNECTION%%" "*})')
    # }}}
fi

# Display the ssh client IP address at the head of PROMPT# {{{
if [ -n "${SSH_CONNECTION}" ]; then
    PROMPT="${SSH_REMOTE_HOST} ${PROMPT}"
fi
# }}}

# これを作る要件は
#
#     日時, ユーザ名, ホスト名, カレントディレクトリ名が見える
#         日時は作業ログをコピペした時にいつやったから知りたいので
#     上記情報を含んだせいでコマンド入力部分が右によらないようにする
#         そのために2行にして全部1行目に詰め込む
#     $RPROMPTは使わない
#         作業ログをコピペした時ひどくなるので
#     git管理ディレクトリの状態が視覚的に分かる
#         ブランチ名（ブランチ上にいなかったらhash）が分かる
#         addされたものがある、diffがある、deleteされたものがある等が分かる
#
# な感じ。
# ちなみにysってテーマがこの要件をほぼ満たしているので、似たようなプロンプト欲しいと思ってる人はそっちのが本家oh-my-zshにあるのでいいかもしれません（ただこのテーマはgit管理ディレクトリがcleanかそうじゃないかしか分かりません）
# ほぼ満たしてるのになんでわざわざ作ったかと言うと、作ってる最中にそれに気づいたからです...
#
# gitディレクトリの状態表示は次のスクショで大体伝わるかと思います。
#
# スクリーンショット 2013-12-23 1.02.46.png
#
# これいい！って思ってくれた方はコードをコピペしてoh-my-zsh/custom/NAME.zsh-themeに保存して（NAMEは好きな名前で）ZSH_THEME=NAMEして使って下さい。あとgitプラグイン使ってるので、plugin=(git)も設定しておく必要があります。
#
# ちなみに散々customに入れろと言いつつ自分ではoh-my-zshをforkしたリポジトリのoh-my-zsh/themes/ディレクトリにおいてバージョン管理してます。
# This post is the No.23 article of zsh Advent Calendar 2013

# vim: foldmethod=marker
