#----------------------------------------
# 履歴関係
#----------------------------------------
HISTFILE=${HOME}/.zsh_history ## 履歴の保存先
HISTSIZE=10000000             ## メモリに展開する履歴の数
SAVEHIST=10000000             ## 保存する履歴の数
setopt hist_ignore_dups       ## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_space      ## 先頭がスペースの場合ヒストリに追加しない
setopt hist_verify            ## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_no_store          ## history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_reduce_blanks     ## 余分なスペースを削除してヒストリに記録する (2009/01/11 15:42 追加)
setopt share_history          ## コマンド履歴ファイルを共有する
setopt append_history         ## 履歴を追加する (毎回 .zsh_history を作らない)
setopt extended_history       ## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt inc_append_history     ## zshを複数起動している時も、コマンドを実行順に記録する
#setopt hist_ignore_all_dups  ## 重複するコマンド行が入力されたら、古い行を削除

## 補完機能の強化
autoload -U compinit
compinit

## 履歴検索機能のショートカット設定
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
# bindkey "^p" history-beginning-search-backward-end
# bindkey "^n" history-beginning-search-forward-end
bindkey "^p" history-beginning-search-backward
bindkey "^n" history-beginning-search-forward
# bindkey "\\ep" history-beginning-search-backward-end
# bindkey "\\en" history-beginning-search-forward-end


#----------------------------------------
# その他
#----------------------------------------

autoload zed                ## 簡易エディタのロード
limit coredumpsize 102400   ## コアダンプサイズを制限
unsetopt promptcr           ## 出力の文字列末尾に改行コードが無い場合でも表示
setopt prompt_subst         ## 色を使う
setopt nobeep               ## ビープを鳴らさない
setopt long_list_jobs       ## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt auto_resume          ## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_list            ## 補完候補を一覧表示
setopt auto_pushd           ## cd 時に自動で push
setopt pushd_ignore_dups    ## 同じディレクトリを pushd しない
setopt extended_glob        ## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt auto_menu            ## TAB で順に補完候補を切り替える
setopt equals               ## =command を command の絶対パス名に展開する (`which <command>` と同じ)
setopt magic_equal_subst    ## --prefix=/usr などの = 以降も補完
setopt numeric_glob_sort    ## ファイル名の展開で辞書順ではなく数値的にソート
setopt print_eight_bit      ## 出力時8ビットを通す
zstyle ':completion:*:default' menu select=1 ## 補完候補のカーソル選択を有効に

## 補完候補の色づけ
# eval `dircolors`
dircolors >/dev/null 2>&1
if [ $? -eq 0 ]; then
    eval $(dircolors ~/.dir_colors)
fi
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

setopt auto_cd              ## ディレクトリ名だけで cd
setopt auto_param_keys      ## カッコの対応などを自動的に補完
setopt auto_param_slash     ## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える

## スペルチェック
# setopt correct
setopt no_correct

setopt brace_ccl            ## {a-c} を a b c に展開する機能を使えるようにする
setopt NO_flow_control      ## Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt list_types           ## 補完候補一覧でファイルの種別をマーク表示
setopt interactive_comments ## コマンドラインでも # 以降をコメントと見なす
setopt mark_dirs            ## ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt list_packed          ## 補完候補を詰めて表示
setopt no_auto_remove_slash ## 最後のスラッシュを自動的に削除しない
setopt no_list_beep         ## ビープ音をならないように設定
setopt no_clobber           ## リダイレクトによる上書きを禁止する
setopt multi_os             ## 複数ファイルのリダイレクトを有効
# setopt cdable_vars          ## 絶対パスが格納された変数をディレクトリパスとして使用する

## 絶対パスが格納された変数をディレクトリパスとして使用する
# こんなオプションはない、と怒られる。
# zsh最強シェル入門ではばっちりと記述されている。
# version の違いが原因か？ (かるく検索しても出てこなかった)
# setopt auto_directory_vars


