#----------------------------------------
# キーバインド
#----------------------------------------
# bindkey -v      ## viライクキーバインド設定
bindkey -e      ## Emacsライクキーバインド設定
#### # -a : コマンドモード
#### # -v : インサートモード
#### # bindkey -a '' redo
#### bindkey -a 'q' push-line    ## コマンドラインスタック
#### bindkey "^R" history-incremental-search-backward    # Ctrl+R is incremental search like a bash.

function peco_select_history() {
    BUFFER=$(\history -r -n 1 | \
        peco --layout=bottom-up --query "${LBUFFER}")
    CURSOR=${#BUFFER}
    zle clear-screen
}
zle -N peco_select_history
bindkey '^r' peco_select_history
