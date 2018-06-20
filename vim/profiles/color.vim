" Color settings

" Note: convenient command for color settings
" １．今、何色でるのか試したい場合。
"
" :so $VIMRUNTIME/syntax/colortest.vim
"
" ２．今、どういうルールでハイライトされているのかを知りたい場合。
"
" :so $VIMRUNTIME/syntax/hitest.vim


colorscheme dracula
set background=dark

if &diff
    colorscheme apprentice
endif
