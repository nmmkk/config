"================================================ 
" ファイルタイプ
"   [TODO]
"     $HOME/rc/filetype.vim との棲み分けは？
"================================================ 
" ファイルタイプのプラグインを有効化
filetype plugin on

" c, perl では構文に従って折り畳む
""" autocmd VimrcAutoCmd FileType c,perl set foldmethod=syntax cindent

""""""" "------------------------------------------------
""""""" " 辞書ファイルの設定
""""""" "------------------------------------------------
""""""" " ファイルタイプ毎に辞書ファイルを指定
""""""" autocmd VimrcAutoCmd FileType perl :set dictionary+=~/.vim/dict/perl_functions.dict
""""""" " Windows では下記と書いていた。
""""""" autocmd VimrcAutoCmd FileType perl :set dictionary+=perl_functions.dict
""""""" " 辞書ファイルを使用する設定に変更
""""""" set complete+=k

" Lastly, source local settings
ResourceLocalProfile local_filetype

" vim: foldmethod=marker
