" Key mapping

" Leader key is changed to "," from "\".
let mapleader = ","
" Swap "\" and ",".
noremap \ ,

nnoremap <F7> :ar<CR>
nnoremap <F6> :N<CR>
nnoremap <F8> :n<CR>

" Insert timestamp
nnoremap <F3> i<C-R>=strftime("%Y-%m-%dT%H_%M_%S")<CR><Esc>
inoremap <F3> <C-R>=strftime("%Y-%m-%dT%H_%M_%S")<CR>

" Move cursor
nnoremap j gj
nnoremap k gk

" Save when something is changed:
" I used to define <Leader><Leader> for this, but it conflicts with easy-motion
noremap \\ :up<CR>

" Edit .vimrc
nnoremap <Leader>E :e $MYVIMRC<CR>
" Reload .vimrc
nnoremap <Leader>R :<C-u>source $MYVIMRC<Enter>:echo 'INFO: $MYVIMRC is just sourced!'<Enter>

" 検索で飛んだ箇所が画面中央にくるようにする
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

"ビジュアルモード時vで行末まで選択
vnoremap v $h

" ヘルプを引きやすくする
nnoremap <C-h> :<C-u>help<Space>
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><Enter>

" Exコマンドを実行しやすくする
nnoremap ;   :
nnoremap :   ;

" VisualMode 中に "*" を押すと、選択範囲の文字列を検索する
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>

" VisualMode 中に "gs" を押すと、選択範囲の文字列を置換対象にする
vnoremap <silent> gs "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>

" 連番を縦にふる
"   引用: http://sites.google.com/site/fudist/Home/vim-nihongo-ban/tips#TOC-13
"   使い方: 1. 初期値を全部の行に設定する。
"           2. <対象の行数>co を実行する。
"                もしくは
"              対象の数値部分を <Ctrl-V> で選択してから co する。
vnoremap <silent> co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor

" 空白以降の文字列を全削除 (プロンプトは出す)
nnoremap <C-F7> :%s/\s\+.*$//gc<CR>

" カーソル下のファイルを開き、さらにウィンドウを縦分割する
nnoremap <Leader>f :vsp<CR>gf


" For QuickFix
nnoremap <C-k>  :cp<CR>
" I don't know why but I need to hit Shift-Ctrl-j to take effect the following.
" In ":verbose nmap" result, actually <NL> is mapped to :cn<CR> instead of <C-j>.
nnoremap <C-j>  :cn<CR>

" Toggle background color on lines at column 80 and greater.
function! ToggleBgcolorColumns(index)
    if exists("g:bgcolor_columns_on")
        set colorcolumn=
        unlet g:bgcolor_columns_on
    else
        execute "set colorcolumn=" .join(range(a:index,9999), ",")
        let g:bgcolor_columns_on=1
    endif
endfunction
if !exists("g:bgcolor_columns_on")
    call ToggleBgcolorColumns(80)
endif
nnoremap <Leader>b :call ToggleBgcolorColumns(80)<CR>

"================================================================================
" Plugin settings that are lead by <Space> + character
" And the actual settings are defined in separate files like "vimrc_gnuglobal".
"================================================================================

"--------------------------------------------------------------------------------
" for NERDTree
"
nnoremap <silent><C-e> :NERDTreeToggle<CR>
let g:NERDTreeBookmarksFile=$HOME . '/rc/vim/NERDTreeBookmarks'
