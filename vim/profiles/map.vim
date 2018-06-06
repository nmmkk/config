" Key mapping

" Leader key is changed to "," from "\".
let mapleader = ","
" Swap "\" and ",".
noremap \ ,


" The following maps to run the program currently edited can be done by QuickRun.
""" "### perl実行 ###"
""" nnoremap <F2> ;w <Enter>;!perl % <Enter>

""" " Run the script you are currently editing.
""" autocmd VimrcAutoCmd BufNewFile,BufRead *.sh nnoremap <F2> :!bash %<CR>
""" autocmd VimrcAutoCmd BufNewFile,BufRead *.rb nnoremap <F2> :!ruby %<CR>
""" autocmd VimrcAutoCmd BufNewFile,BufRead *.py nnoremap <F2> :!python %<CR>
""" autocmd VimrcAutoCmd BufNewFile,BufRead *.pl nnoremap <F2> :!perl %<CR>




"### ファイル移動 ###"
nnoremap <F7> :ar<CR>
nnoremap <F6> :N<CR>
nnoremap <F8> :n<CR>

" Insert timestamp
nnoremap <F3> i<C-R>=strftime("%Y-%m-%dT%H_%M_%S")<CR><Esc>
inoremap <F3> <C-R>=strftime("%Y-%m-%dT%H_%M_%S")<CR>

""""""""""""" " Use s as prefix of various commands. (BTW, Default s behavior is achived by cl.)
""""""""""""" nnoremap s <Nop>
"### タブ操作を快適に
"""" """ 以下2つは gtags のために開放することにした。
"""" map <C-n> ;tabnext<Enter>
"""" map <C-p> ;tabprevious<Enter>
""" 2016-04-07: As gtags kep mapping uses differnt leader key other than Ctrl now. So re-enabled the followings.
""""""""""""" nnoremap sn :tabnext<Enter>
""""""""""""" nnoremap sp :tabprevious<Enter>
""" Disable the following one to get the original C-t back working.
""""""" map <C-t> ;tabnew<Enter>

"### ペースト・モード切り替え ###"
""" 2016-03-08T17:42:58
""" I just noticed that the following 2 mappings do not work within tmux.
""" map <C-F11> ;se paste<Enter>;echo "INFO: Entering paste mode"<Enter>
""" map <C-F12> ;se nopaste<Enter>;echo "INFO: Entering nopaste mode"<Enter>

""" I just noticed that the following 2 mappings do not work within tmux.
" set pastetoggle=<F12> "This also works, but I wanted to print something when it is toggled.
nnoremap <F12> :se invpaste <CR>:echo "INFO: Just executed invpaste"<CR>

"### カーソル移動 ###"
nnoremap j gj
nnoremap k gk

"### カーソル移動
" map!  la
" map!  i
" map!  ka
" map!  ja

"====================================================================
" Mapping of special keys - arrow keys and function keys.
"====================================================================
" Buffer commands (split,move,delete) -
" this makes a little more easy to deal with buffers.
"""""""" map <F6> :split<C-M>
"""""""" map <F7> :vsplit<C-M>
"""""""" "map <F6> :bp<C-M>
"""""""" "map <F7> :bn<C-M>
"""""""" "map <F8> :bd<C-M>

" Switch windoes
""" map <C-Down> <C-w>j
""" map <C-Up> <C-w>k
""" map <C-Left> <C-w>h
""" map <C-Right> <C-w>l
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Left> <C-w>h
nnoremap <C-Right> <C-w>l
"""""""" map <C-j> <C-w>j<C-w>_
"""""""" map <C-k> <C-w>k<C-w>_
"""""""" map <C-h> <C-w>h<C-w>_
"""""""" map <C-l> <C-w>l<C-w>_
""""""""""""" nnoremap sh <C-w>h
""""""""""""" nnoremap sj <C-w>j
""""""""""""" nnoremap sk <C-w>k
""""""""""""" nnoremap sl <C-w>l

"""""""" " <Tab> is bound to `complete'
"""""""" "inoremap <tab> <c-p>

"""""""" " cycle fast through buffers ...
"""""""" nnoremap <C-n> :bn<CR>
"""""""" nnoremap <C-p> :bp<CR>

"""""""" " cycle fast through errors ...
"""""""" map <m-n> :cn<cr>
"""""""" map <m-p> :cp<cr>

" <Leader><Leader>で変更があれば保存
noremap <Leader><Leader> :up<CR>

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

" toggle <s>pell   URL: http://d.hatena.ne.jp/h1mesuke/20100803/p1
nnoremap <silent> <Leader>s :<C-u>setlocal spell! spelllang=en_us<CR>:setlocal spell?<CR>

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

" カッコを入力した後、左に戻る
" (http://www.e2esound.com/wp/2010/11/07/add_vimrc_settings/)
"
" これは、Function() みたいな記述をするときに煩わしいので、無効化した。
"" imap {} {}<Left>
"" imap [] []<Left>
"" imap () ()<Left>
"" imap “” “”<Left>
"" imap ” ”<Left>
"" imap <> <><Left>
"" imap “ “<Left>

"### 括弧類を自動で閉じる ###"
" inoremap { {}<LEFT>
" inoremap [ []<LEFT>
" inoremap ( ()<LEFT>
" inoremap " ""<LEFT>
" inoremap ' ''<LEFT>
" vnoremap { "zdi^V{<C-R>z}<ESC>
" vnoremap [ "zdi^V[<C-R>z]<ESC>
" vnoremap ( "zdi^V(<C-R>z)<ESC>
" vnoremap " "zdi^V"<C-R>z^V"<ESC>
" vnoremap ' "zdi'<C-R>z'<ESC>

" Toggle highlight
nnoremap <silent><Esc><Esc>     :<C-u>set hlsearch!<CR>

" カーソル下のファイルを開き、さらにウィンドウを縦分割する
nnoremap <Leader>f :vsp<CR>gf

""""""""""""" """ " Open man in a new tab ==> I installed "thinca/vim-ref" on 4/11/2016
""""""""""""" nnoremap K :execute 'tabnew <bar> read !' . &keywordprg . ' ' . expand("<cword>")<CR>gg:set syntax=man<CR>

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
