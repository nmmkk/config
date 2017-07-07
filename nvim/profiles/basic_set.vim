" Basic settings for Vim

" Where to store backup files
set backupdir=$HOME/.vim/tmp

" Following is listed as a anti-pattern, so it is commented out.
" Ref: http://rbtnn.hateblo.jp/entry/2014/11/30/174749
" set nocompatible

" Indenting "{{{1
set expandtab  " Use spaces for indenting instead of Tab
set tabstop=4
set softtabstop=4
" set smarttab  " 行頭の連続した空白に限り、'shiftwidth'分だけ入力・削除する
set autoindent
set smartindent
set shiftwidth=4
set textwidth=0  " Disable auto-indent
" }}}1

" Search" {{{1
set incsearch
set noignorecase
set nosmartcase
set hlsearch
" }}}1

" Cursor" {{{1
set whichwrap=b,s,[,],~
set number
"""""""" set cursorline
" backspaceキーの挙動を設定する
"   indent    : 行頭の空白の削除を許す
"   eol       : 改行の削除を許す
"   start     : 挿入モードの開始位置での削除を許す
set backspace=indent,eol,start
" }}}1

" Bracket" {{{1
set showmatch
set matchtime=1
" }}}1

" Tag jump" {{{1
source $VIMRUNTIME/macros/matchit.vim   " Enhance '%'
" }}}1

" Command-line Completion " {{{1
set wildmenu
set history=5000
" }}}1

set cinoptions=;0,p0,t0
set cinwords=if,else,while,do.for.switch,case
set formatoptions=tcq

" Clipboard"{{{1
if has('gui_running')
    set clipboard+=unnamed      " 無名レジスタに入るデータを、*レジスタにも入れる
    set guioptions+=a           " GUI版vimエディタで、マウス操作を可能にするならこの設定を有効にする
else
    " set clipboard+=autoselect   " GUI版でない場合は、こちらの設定を追加する " This does not work on nvim
endif
"}}}1

" Status line"{{{1
set laststatus=2
set statusline=%F%m%r%h%w\ [ENCODE=%{&fenc!=''?&fenc:&enc}]\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"}}}1

" Folding"{{{1
set foldmethod=marker               " 折りたたみ方式のデフォルトはマーカーに
set foldlevel=100                   " ファイルを開いたときに自動で折り畳むレベル(深さ)
"}}}1

" マウスでのジャンプを有効
" set mouse=a

" カーソル行・列の強調表示
" set cursorline
" highlight CursorLine ctermbg=DarkGray
" highlight CursorLine ctermfg=none
" highlight CursorLine cterm=none
" highlight CursorLine ctermfg=NONE ctermbg=darkgray cterm=NONE

" アンダースコアを見られるように、色を反転する
"   (http://kaworu.jpn.org/kaworu/2008-05-28-1.php)
" highlight CursorLine term=reverse cterm=reverse

" set cursorcolumn
" highlight CursorColumn ctermbg=Gray
" highlight CursorColumn ctermfg=Green

" ctags で生成した tags ファイルの捜索先
set tags+=../tags,../TAGS,/usr/lib/perl5/tags

set t_vb=                   " ビープ音を消す
set visualbell              " ビジュアルベルを有効化

" set spell                       " デフォルトではスペルチェックを有効化

" File search path"{{{1
set path=.
set path+=/usr/include
"}}}1

" Ctrl-a でのインクリメントに関する設定
set nrformats=hex

" 256色表示にする
set t_Co=256

" 不可視文字を可視化する
set listchars=eol:$,tab:>=,trail:_

" 外部grepを使用する
set grepprg=grep\ -nH

" Wihtout termguicolors, NeoVim does not display color properly on my Linux
" Ref: https://github.com/dracula/vim/issues/11
set termguicolors

" Close quickfix with 'q'
autocmd FileType qf nnoremap <silent><buffer>q :quit<CR>

" Lastly, source local settings
ResourceLocalProfile local_basic_set

" vim: foldmethod=marker
