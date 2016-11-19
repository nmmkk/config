" for GNU GLOBAL (gtags)
nnoremap [GnuGlobal] <nop>
nnoremap <Space>g [GnuGlobal]

""""        ,q     検索結果Windowを閉じる
"        [GnuGlobal]g     ソースコードの grep
"        [GnuGlobal]l     このファイルの関数一覧
"        [GnuGlobal]j     カーソル以下の定義元を探す
"        [GnuGlobal]k     カーソル以下の使用箇所を探す
"        [GnuGlobal]n     次の検索結果へジャンプする
"        [GnuGlobal]p     前の検索結果へジャンプする
" nnoremap <silent> [GnuGlobal]q     <C-w><C-w><C-w>q

" Launch grep mode
nnoremap <silent> [GnuGlobal]g     :Gtags -g

" Display list of fucntions in the file.
nnoremap <silent> [GnuGlobal]l     :Gtags -f %<CR>

" Jump to where the target is defined.
""" nnoremap <silent> [GnuGlobal]j     :Gtags <C-r><C-w><CR>
nnoremap <silent> [GnuGlobal]j     :GtagsCursor<CR>

" Jump to where the target is used.
nnoremap <silent> [GnuGlobal]k     :Gtags -r <C-r><C-w><CR>

" Jump to the next item in quickfix.
nnoremap <silent> [GnuGlobal]n     :cn<CR>
""" nnoremap <C-j>  :cn<CR>  " ==> Moved to map.vim

" Jump to the previous item in quickfix.
nnoremap <silent> [GnuGlobal]p     :cp<CR>
""" nnoremap <C-k>  :cp<CR>  " ==> Moved to map.vim
